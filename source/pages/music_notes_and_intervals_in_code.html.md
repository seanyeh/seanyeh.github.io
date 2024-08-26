---
title: "The Coordinate System: representing music in code"
created: 2024-08-25
tags: [music, music theory, tech]
abstract: "A brief overview of tha simple and elegant approach to representing music notes and intervals"
---

Most musicians think of [intervals](https://en.wikipedia.org/wiki/Interval_(music)) as some combination of semitones, scale degrees, and/or distances between letter names. A common method that I learned as a musician was to use the major scale as a reference for Major and Perfect intervals, adjusting with half steps as needed (while keeping the letter name).

In working on a [music theory library](https://github.com/seanyeh/mystic.cr) for Crystal just for fun, I found these human-like approaches surprisingly tricky to develop algorithms for. The simplest and naive approach of note/interval representation would be to use a purely semitone-based system. This, however, makes representing enharmonic notes (F# vs. Gb) near impossible, and I've seen some music theory libraries just accept this limitation. An improvement could be to keep track of half step adjustments, allowing for accurate note representation. However, this will require special considerations, such as flipping adjustments for negative intervals and differing adjustments for perfect vs. imperfect intervals, not to mention silly mathmatical adjustments like `3 + 3 = 5` and `3 - 5 = -3` for interval sizes. Overall, this approach would be quite messy.

## The Coordinate System

_(I'm not aware for a name of this system so I will be calling it "the Coordinate System". Please let me know if you're aware of a different name)_

I first learned of this technique when looking at the code of some music theory libraries, but I couldn't find much information about it otherwise. Luckily, it's quite elegant and easy to understand.

**The main idea is to represent intervals as coordinates of** `(fifths, octaves)`.

For example a major 2nd is represented as `(2, -1)`, meaning 2 fifths up, 1 octave down. A major 3rd is represented as `(4, -2)`. Adding intervals this way is trivial: `(2, -1) + (4, -2) = (6, -3)`, where `(6, -3)` is the coordinates of an augmented 4th.

What's great is that there's no need for hacks to spell notes correctly, as enharmonically equivalent intervals have entirely different representations. For example: an augmented 4th is `(6, -3)` but a diminished 5th is `(-6, 4)`. (This also works with notes as well, by treating the note as an interval relative to middle C)

Converting coordinates back to notes takes some work, but it's not complicated. Just add the 5ths starting from C, remembering to add a sharp for every 7 5ths (starting from the 6th) when going up, and a flat for every 7 5ths (starting from the 2nd) going down. Lastly, apply the octave adjustment.

What's so great about this system is that it takes care of enharmonic spelling out of the box. For a (human) musician, this system is pretty unintuitive, since we're used to thinking of notes and intervals as is. But for a computer, this makes music theory math much more elegant!
