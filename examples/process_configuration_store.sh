#!/bin/bash

doc_string="
A script which parses a configuration store file from a VOLTTRON platform into a
directory structure suitable for use in the ansible-based recipe system.  For
each configuration store entry, the key is parsed as a path and the full
directory structure generated.  In the event that a key is an exact subset of
another key (i.e. some path would need to be both a file and a directory), a
directory is created with '.d' appended to the name, with the file keeping the
original name.  The recipes system will ignore the '.d' ending of any directory
name when parsing the paths back into keys.

Options:
  -cs (--configuration-store) is the full path to the configuration store file
  -o (--output-dir) is the directory within which the configuration store
                    output files will be placed (this directory can be passed
                    to an agent's spec in the recipe system; when doing so it is
                    not included as part of the generated keys).
"

if ! [ -x "$(command -v jq)" ]; then
  echo "this script requires the jq command line tool; please install (https://stedolan.github.io/jq/download/)" >&2
  exit 1
fi

config_store_path=""
output_dir_path=""
## parse arguments
while (( "$#" )); do
  case "$1" in
    -h|--help)
      printf "${doc_string}"
      exit 0
      ;;
    -cs|--configuration-store)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        config_store_path=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -o|--output-dir)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        output_dir_path=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    *)
      echo "unrecognized argument '$1'" >&2
      exit 1
      ;;
  esac
done
## validate arguments and compute vars
if [ -z "$config_store_path" ]; then
  echo "path to configuration store (-cs PATH_TO_FILE or --configuration-store PATH_TO_FILE) is required)." >&2
  exit 1
fi
if [ -z "$output_dir_path" ]; then
  echo "path to output directory (-o PAT or --output-dir PATH) is required)." >&2
  exit 1
fi
if [[ ! $config_store_path == *\.store ]]; then
  ## Note: could probably expand logic here to support other patterns, left as an exercise to whoever needs that
  echo "the input config store must end in '.store'"
  exit 1
fi
mkdir -p $output_dir_path

## do the parsing
cat $config_store_path | jq -c 'keys[]' | while read an_entry; do
  echo "entry is ${an_entry}"
  this_out_dir=${output_dir_path}/$(dirname $(echo $an_entry|tr -d '"'))
  this_out_file=$(basename $(echo $an_entry|tr -d '"'))
  if [ -f $this_out_dir ]; then
    this_out_dir=${this_out_dir}.d
  fi
  mkdir -p ${this_out_dir}
  echo "-> put output in [${this_out_dir}]/[${this_out_file}]"
  cat $config_store_path | jq -r ".[$an_entry].data" | cat > ${this_out_dir}/${this_out_file}
done
