
### Instructions for homology modeling example 1w6y

*1w6y.fasta*
---

the fasta file for the protein sequence	to be modeled

---

*./templates/*
---
These are threaded templates for the input to Rosetta homology modeling. They are created from using an alignment file (in the Grishin file format) and the partial_thread Rosetta app. By passing in the template pdb files, the sequence you want to model is place on the positions of the template where the sequence is the same. If the sequence to model is different from the template pdb sequence, it is skipped and left empty for Rosetta to fill in later. These are created from running partial_thread... see below explaination for constraint files

---
*flags*
---
Look inside this file for more descriptions of the flags needed to run

---
*hybridize.xml* 
---
This file sets up the movers needed for homology modeling. This file actually only contains 1 mover (hybridize), the other lines are just setting it up to work. The scorefunctions for stage 1 2 and 3 are different files that contain the score terms, with different weights to apply for different stages of modeling

---
*upweighted.alignment.grishin.trim.dist_csts*
---

The majority of the lines in this constraint file where created using Robetta's program called "predict_distances_multi.pl" written by James Thompson. All of the lines, except for the very bottom of the file, are created by overlaying the template pdbs, measuring the distances between equivalent pairs of residues (equivalence is determined by the alignment file) and making a gaussian mixture model to estimate a contraint for a specific interaction. This is essentially putting rubber bands all over the structure to make sure that the structure looks like the templates. The very last lines are the catalytic constraints. These can be created by taking a list of "catalytic residues" and a pdb structure and calculating the distances between all of the atoms.

Command line to create the upweighted.alignment.grishin.trim.dist_csts file

```
$ROBETTA/cm_scripts/bin/predict_distances_multi.pl alignment.grishin 1wy6.fasta  -outfile alignment.grishin.dist_csts -min_seqsep 5 -max_dist 10 -aln_format grishin -max_e_value 10000 -pdb_dir PATHTHATCONTAINSPDBS
```

alignment.grishin is in the extra files. To create this file, you take the target sequence and the sequences from the pdb, align them using MUSCLE, or PROMALS3D or some other alignment program, then format is to a grishin-style format (grishin being a reference to Nick Grishin. The style allows you to embed multiple alignments in a single file)

$ROSETTA_BIN/partial_thread.default.linuxgccrelease -in:file:fasta 1w6y.fasta -in:file:alignment alignment.grishin -in:file:template_pdb 1buq.pdb 1isk.pdb 1ocv.pdb 1ogz.pdb 1ohp.pdb 3m8c.pdb 3mhe.pdb 3ov4.pdb 4l7k.pdb 8cho.pdb -ignore_unrecognized_res T -overwrite T

PATHTHATCONTAINSPDBS - these pdb codes and files must match the names in the alignment.grishin file

---

*fragment files*
---

These are created from the perl script "make_fragments.pl" which is a part of Rosetta. That program takes a Fasta file of a sequence to be modeled and then extracts 200 fragments for every single 3 and 9 mer frame over the whole sequence from the pdb database. In other words, it steals the ideal coordinates for a given sequence (say the peptide sequence EGE, will go into the PDB and copy the backbone torsion angles from any PDB that has that same sequence. If it cant' find that exact sequence, it will look for something that is chemicall similar... DGE). This essentially builds a bucket of torsion angles to try applying to the protein sequence that are biased Rosetta to make sequences that are similar to those found in the PDB to have similar torsion angles.

command line to create fragments from a fasta file

```
/share/backup/bertolan/frag_picker_do_not_touch/Rosetta/tools/fragment_tools/make_fragments.pl -verbose -id 1w6y_ 1w6y.fasta
```

---



```python

```
