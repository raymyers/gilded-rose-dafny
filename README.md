# Gilded Rose in Dafny

Code for the video [Refactoring With Proofs](https://youtu.be/XNIdKXQ56o4) on Craft vs Cruft.

For background on the Gilded Rose Kata, see Emily Bache's [repo](https://github.com/emilybache/GildedRose-Refactoring-Kata).

This version has been ported to [Dafny](https://dafny.org) for practice with program proofs.

## Branches

**main** - Ported code and main method to replicate the golden file
**specification** - Basic pre/post conditions added, a good starting point
**solution** - Full formal specifications, and implementation replaced with pure functions

## Development

It's recommended to install dotnet Dafny and its VS Code extension. Then you can get proof feedback within in the editor.

## Testing

```
make test
```
