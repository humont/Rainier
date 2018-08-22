# Database Organization

To the user it appears that there’s just one big database.

However, it’s not true that it’s just one big file. The database is composed of virtual databases (system, temp) and separate files (suites, user data).

The app puts those all together at runtime and creates the illusion of a single database.

Below are the top-level tables.

All Rainier tables that live on disk are stored in `~/Documents/Rainier/`.

## system

Generated at runtime. See [System Table Organization](SystemTableOrganization.markdown).

## workspace

Place for simple and one-off scripts — things that don’t rise to the level of suites. Stored in workspace.rainier on disk.

## suites

Stored in `~/Documents/Rainier/Suites/` as separate files — suiteName.rainier.

## temp

An empty table generated at runtime, available for use by any scripts. Does not persist.

## scratchpad

Like temp, but persistent. Stored in scratchpad.rainier on disk.

## user

Data stored by Rainier itself are stored at `user.Rainier` and are stored at `~/Documents/Rainier/User/Rainier.rainier`.

Each suite automatically gets a data file created (if needed), and they’re mounted at `user.suiteName`, and are also stored in `~/Documents/Rainier/User/`.
