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
ansible-galaxy install git+https://github.com/volttron/volttron-ansible.git
```

## Documentation

Documentation of the components here is rendered on [Read the Docs](https://volttron.readthedocs.io/projects/volttron-ansible/en/main/).

## Additional resources

As always, VOLTTRON community members are encouraged to engage with the core team if you have questions about these features or require assistance.
This can be done through typical channels:
- stack overflow questions tagged with 'volttron'
- email ([web submission form](volttron.org/contact) is available)
- slack (use the above email form to request access if you're not already a member)
