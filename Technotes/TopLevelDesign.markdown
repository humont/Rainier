# What Is Rainier?

Rainier is an automation app for macOS with an integrated database, scripting language, and debugger.

It’s heavily inspired by UserLand Frontier, but is not compatible with it.

It’s meant to be used for on-machine scripting (database, file system, inter-application communication, and so on) and for web scripting and web services.

## The Main Idea: the Enviroment

The app is the development environment *and* the runtime *and* persistent storage. You write, debug, and run scripts all in the app.

You also browse and edit the built-in database while in the app. Your scripts live in that database — and so does your data.

Scripts can call other scripts, and scripts can easily create, update, and delete data in the database.

### Hierarchical Storage

The database is not a SQL database. It’s made up of tables, and each table contains key-value pairs — and those values can also be tables.

Think of it as a big nested dictionary.

Though there are conventions that suggest some common structures, the database is entirely free of schemas. You can put anything anywhere.

Also: the database keys are case-insensitive. This is not UNIX-like, but it is traditionally Mac-like.

#### Data types

The database holds not just strings, tables, and scripts but also standard types such as integers, doubles, booleans, dates, and binary data.

It also holds certain types of special data: outlines and menus.

Some data types can have a subtype, which is a Mac Universal Type Identifier. For instance, if a binary is a PNG image, its type is `binary` and its subtype is `public.png`.

### Scripting Language

The scripting language — named Ballard — is procedural and simple, and works natively with the database.

Using persistent storage is as simple as this:

	user.prefs.name = "George Washington"

The `user.prefs.name` part is a database path: it refers to `name`, which is in the `prefs` table, which is in the `user` table.

After that line runs, the type of `user.prefs.name` is now `String` and the value is "George Washington".

And if you quit and re-launch the app, that value is still present. Persistence is that easy.

#### Scripts as Outlines

All scripting is done in an outliner. This makes hiding/showing and reorganizing code easy. The script editor includes syntax coloring and auto-complete.

Scripts are debugged in that same outline view. Standard debugging commands appear — step, continue, and so on.

You can also view the entire stack while debugging. Each stack frame is a table.

#### Standard Library

The database contains a `system` table (and subtables) that contains the standard library for the scripting language.

The standard library includes verbs in a wide variety of categories, from operating on data, to scripting Rainier and other apps, to working with JSON, to downloading data from the web, and so on.

### Workspace

For simple scripts, there’s a `workspace` table. Typically these scripts don’t need to call related scripts — they use the standard library and, possibly, other libraries that have been installed.

### Suites

Users can create and distribute “suites,” which are either libraries, apps, or both.

For example, to extend Rainier to provide verbs that work with, say, the Mercurial source code management system, a user would create a suite named Mercurial, and inside that suite would be a number of scripts that work with Mercurial repositories.

Suites that are also apps might provide a menubar, with scripts attached to the menu items. When a suite is made current, its menu, if present, appears in the main menubar along with Rainier’s standard menu. (Rainier includes a menu editor.)

A suite might, for instance, generate a blog and upload it to a server. The suite could have a command for building the blog.

Suites are distributed as separate files, but they appear to the scripter as part of the single database.

Importantly, there is no removing of source code. If you distribute a suite, every user can read all the source code. (And modify it too, actually, though their changes would be overwritten if they install an update to the suite.)

Also: each suite gets its own table of data storage (which can include subtables, just like any other table: there are no limitations other than disk space).

### User Interface

It’s a three-paned app. The left-hand sidebar shows top-level items, including suites, and it includes a bookmarks section for easy navigation to favorite places.

The middle pane is the database browser. It’s an outline view. Tables can be expanded and collapsed. The browser has three columns: name, type, and value. When a value is too large to show succintly, it shows (for instance) the first part of the text, or whatever preview makes sense.

The third, right-most pane is the value editor. It might be a text view for editing a string, an outline for editing a script, and so on.

Some editors can be opened in separate, editor-only windows.

Opening secondary windows like the main window is supported, and window tabs are also supported.

An Open Quickly command allows the user to jump to any location in the database.

### Scripts and User Interface

Scripts can run simple dialogs to get input, or even show and run a window loaded from a nib or storyboard.

Scripts can also create small web-based apps that run locally, where the user interface appears in the browser.
