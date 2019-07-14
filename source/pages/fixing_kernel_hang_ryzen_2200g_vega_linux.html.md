---

title: Fixing kernel hangs on Ryzen 2200g + Vega 8 graphics on Linux
created: 2019-07-20

tags: [gaming, linux, tech]
abstract: "I recently built a cheap gaming pc with the Ryzen 2200g processor with Vega 8 graphics. It worked well for many things, but for certain games (or totally randomly), the kernel would hang"

---

### Problem

I recently built a cheap gaming pc with the Ryzen 2200g processor with Vega 8
graphics. It worked well for many things, but for certain games (or totally
randomly), the kernel would hang, requiring a
[REISUB](https://en.wikipedia.org/wiki/Magic_SysRq_key) restart.

The kernel log (`/var/log/kern.log`) would usually show erorrs such as:
`[drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout`

A quick online search showed that this was a known problem, and I tried many of
the suggested solutions -- various kernel boot options, newer kernel versions
(including compiling my own linux 5.2 kernel), and newer graphics drivers --
with no success.


### Solution

(For the record, I'm running Ubuntu 18.04, kernel version 4.18.0.24-generic. YMMV for
other distros.)

The solution that worked for me was super simple. Installing the
[Radeon drivers](https://www.amd.com/en/support/kb/release-notes/rn-rad-lin-19-10-unified)
directly from amd's website did the trick. Surprisingly, this didn't
come up in my searches.

For Ubuntu, download the "Radeon™ Software for Linux® version 19.10 for Ubuntu
18.04.2", extract the archive, and then run `./amdgpu-pro-install -y`. That's
it!
