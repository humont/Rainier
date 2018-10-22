# System Table Organization

The system table can’t be edited by the user.

It’s entirely virtual: it’s created by the app at runtime and resides entirely in memory.

To attempt to change it via a script throws an error.

This policy provides a guarantee that the system cannot change until there’s a new version of the app.

## Standard Library: system.verbs

This includes tables of verbs: date, string, file, etc. Each subtable has one or more scripts (that almost always call into the kernel).

These also include a few verbs that aren’t in subtables: `defined`, `typeOf`, etc.

## Constants: system.constants

This contains key/value pairs such as `maxInteger` that can be useful.

This also includes subtables — for instance, the standard http result codes live in a table at `system.constants.httpResultCode`.

## Environment: system.environment

This contains information about the operating system and machine where Rainier is running.

## Errors: system.errors

The names are numbers — error codes — and the value of each is a string describing the error.

## Search Paths: system.paths

This provides paths to use when resolving an address, in search order. Importantly, @system.verbs and @system.constants are included, so you can refer to `file.readWholeFile` instead of having to type `system.verbs.file.readWholeFile`. You can refer to `httpResultCode.ok` instead of `system.constants.httpResultCode.ok`, etc.

The list looks like this:

* @system.verbs
* @system.constants
* @system

If a path can’t be resolved by checking these paths first, then it looks at top-level tables until it resolves (or fails to resolve).

