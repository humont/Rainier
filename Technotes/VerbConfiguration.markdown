# Verb Configuration

The verbs in the standard library are shells that call into the kernel.

Each set of verbs has an object that implements all the verbs in the set. Each verb implementation is a method that takes an object describing the parameters sent to it.

Verbs are configured in an OPML file. The configuration for each set looks like this:

name
* Description — what these verbs are for
* Class name — the thing that implements the verbs
* Verbs - One or more verbs

The configuration for each verb looks like this:

verbName
* Parameters — string representing the parameters, as in `date, year` or `x, y, z=nil` or whatever.
* Selector - as in `addYear:` or `readWholeFile:` — the name of the method that implements the verb
* Docs — dictionary that borrows names from [Script Docs](ScriptDocs.markdown)
