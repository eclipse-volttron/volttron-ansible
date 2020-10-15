This repo contains the ansible-based components for managing deployments of the VOLTTRON platform.
It includes an ansible-galaxy collection, as well as a number of playbooks which can either be used directly,
or taken as examples for custom playbooks.

## Installing

Note that ansible-galaxy collections require ansible 2.9 at minimum.
This is newer than that provided by, for example, debian buster's package repo.
The version installed through pypi (`pip3 install ansible`) is sufficient.

You can install this collection directly from the [source repository](https://docs.ansible.com/ansible/devel/user_guide/collections_using.html#installing-a-collection-from-a-git-repository).
That would typically look like:

```
ansible-galaxy collection install git+https://github.com/volttron/volttron-ansible.git
```

## Documentation

Documentation of the components here is currently included with the main VOLTTRON project's [documentation](volttron.readthedocks.io).

## Additional resources

As with any feature, VOLTTRON community members are invited to engage with the core development team for assistance using these tools.
