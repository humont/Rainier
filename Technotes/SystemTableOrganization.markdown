# System Table Organization

The system — root.system — can’t be edited by the user.

It’s entirely virtual: it’s created by the app at runtime, resides entirely in memory, and is never altered.

To attempt to change it via a script throws an error.

This policy provides a guarantee that the system cannot change until there’s a new version of the app. This means we sidestep the problem that Frontier sometimes had, where a user would edit the system and then an update from UserLand would overwrite their changes.

Better to just be explicit and enforce a policy that the system can’t be changed.

## Standard Library: system.verbs

This includes tables of verbs: date, string, file, etc. Each subtable has one or more scripts (that almost always call into the kernel).

These also include a few verbs that aren’t in subtables: `defined`, `typeOf`, etc.

## Constants: system.constants

This contains values such as `maxInteger` that can be useful.

## Environment: system.environment

This contains information about the operating system and machine where Rainier is running.

## Mounts: system.mounts

This table includes information about files — suites, user data — that are mounted as part of the database.

## Search Paths: system.paths

This provides paths to use when resolving an address, in search order. For instance, @system.verbs and @system.constants are included, so you can refer to `file.readWholeFile` instead of having to type `system.verbs.file.readWholeFile`.


