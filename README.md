# aix_vios_facts

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with aix_vios_facts](#setup)
    * [What aix_vios_facts affects](#what-aix_vios_facts-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with aix_vios_facts](#beginning-with-aix_vios_facts)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The cryssoft-aix_vios_facts module populates the $::facts['aix_vios'] hash with 
a few values that are of interest if you're using Puppet to manage both VIO
servers and clients.  Relying only on $::facts['osfamily'] and the like can get
you into trouble, so look deeper to see if your rule is attempting to update
an AIX 6.1 system or a VIOS 2.2 system, an AIX 7.2 system or a VIOS 3.1 system.

## Setup

Put the module in place in your Puppet master server as usual.  AIX-based systems
will start populating the $::facts['aix_vios'] hash with their next run, and you
can start referencing those facts in your classes.

### What aix_vios_facts affects

At this time, the cryssoft-aix_vios_facts module ONLY supplies custom facts.  It 
does not change anything and should have no side-effects.

### Setup Requirements

As a custom facts module, I believe pluginsync must be enabled for this to work.

### Beginning with aix_vios_facts

If you're using Puppet Enterprise, the new fact(s) will show up in the PE console
for each AIX-based node under management.  If you're not using Puppet Enterprise,
you'll need to use a different approach to checking for their existence and values.

## Usage

As notes, cryssoft-aix_vios_facts is only providing custom facts.  Once the module
and its Ruby payload are distributed to your AIX-based nodes, those facts will be
available in your classes.

## Reference

$::facts['aix_vios] is the top of a small hash.  That's it.

## Limitations

This should work on any AIX-based system.  If it's not a VIO server, it will say so.
If it is a VIO server, it will say so and give you some extended version info in the
hash.

NOTE:  This has only been tested with VIOS 2.2.6.x at this point.  It should work
with 3.1.x, but I don't have a test environment for it yet.

## Development

Make suggestions.  Look at the code on github.  Send updates or outputs.  I don't have
a specific set of rules for contributors at this point.

## Release Notes/Contributors/Etc.

Starting with 0.3.0 - Pretty simple stuff.  Not sure if this will ever morph into a
control/configuration module with types/providers/etc. to actually do anything 
meaningful about controlling VIO servers.
