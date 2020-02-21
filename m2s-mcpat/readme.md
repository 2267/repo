# m2s-mcpat
scripts to convert the reports from m2s into xml input files for mcpat

m2s-mcpat works under the version of: 
- multi2sim   : 4.2
- mcpat : 1.3

**usage: python3 xml.py <output.xml> <x86.report> <mem.report>**

to use these scripts, you need to name your modules in m2s like these:
- cpu : keep the origin form, like c0t0
- cache : 
  - icache  : cache-i0 [cache-i1...]
  - dcache  : cache-d0 [cache-d1...]
  - l2cache : cache-l20 [cache-l21...]
  - l3cache : cache-l30 [cache-l31...]
  - if you wants more than 3 levels, you need to modify reader.py
- memory:
  - mem
- net : 
  1. net-l1-mm
  2. net-l1-l2 net-l2-mm
  3. net-l1-l2 net-l2-l3 net-l3-mm

---

some things you need to know:
- m2s-mcpat only support homogenerous configurations
- only at most 3 levels caches can be captured
- some configures need modified by hand,can be changed directly in xml.py, including: tech node, temperature, the configurations of CPU and so on. besides, the configurations of caches are specified in reader.py (def config)
- i don't guarantee the correctness of this tool, one of the reasons is that the descriptions and statistics in m2s is not completely as the same as mcpat. you can feel free to change these scripts to fullfill your demands
