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

Like temp, but persistent. Stored in `Scratchpad.rainier` on disk.

## user

Data stored by Rainier itself are stored at `user.Rainier` and are stored on disk at `~/Documents/Rainier/User/UserRainier.rainier`.

Data used for workspace scripts is stored at `user.workspace` and is stored on disk at `~/Documents/Rainier/User/UserWorkspace.rainier`.

Each suite automatically gets a data file created (on demand), and they’re mounted at `user.suiteName`, and are also stored in `~/Documents/Rainier/User/`, and the filename is `UserSuiteName.rainier.`

(The reason we start the file name with `User`, even though the folder is also called User, is just in case somebody passes one of these around or they get moved accidentally. That way we still know they’re user tables.)
