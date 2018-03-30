
### Instructions for docking example 1w6y

*1w6y.enzdes.cst*
---

This file tells Rosetta how to make the ligand interact with the protein. Although Rosetta has an energy function, it was trained for modeling protein folding, and not small molecul to protein interactions. Therefore, we tell it exactly how the interactions should look like from standard organic chemical knowledge. See inside the file for more details on the constraints

---
*1w6y.docked_input.pdb*
---

This file contains the PDB structure of the protein , and also the ligand is bound in the active site. This file was made by running rosetta docking subject to the constraints in the enzdes file. Note the top of the file the lines that start with REMARK... These map the constraints written in the enzdes file to individual resides. So in the enzdes cst file, the first constraint tells Rosetta that the oxygen on the ligand should be interacting with the TYR residue on the protein, but it does not say which TYR residue. The REMARK line specifies that its for the TYR16 residue. This specification in the protein PDB file allows you to use the exact same constraint file, for many different PDB files. Just as long as you change the REMARK lines to map to the correct residues.

---
*1w6y.params*
---

This file tells Rosetta how to treat the small molecule. In Rosetta, a ligand is a special type of Residue object. Normally, a Residue will be 1 of the 20 canonical types (ASP, ALA, TYR etc). But the ligand is a 21st kind of residue. Rosetta knows how to score how residues interacted with each other, but have no idea how to treat a small molecule, or what kinds of conformations it has, or how to even build the 3d version of it. The params file is usually created from a 3D mol file of the compound, using a python script in Rosetta called  molfiletoparams.py.


The first line sets an internal name, the 2nd line sets the string to expect in the PDB file. The third line sets the residue to LIGAND (as opposed to DNA or PROTEIN) so that Rosetta will turn on certain calculations and ignore others. The lines that start with ATOM give the numbering, atom type and charge for every atom. The BOND_TYPE lines set bonds (single, double, etc) between atoms. The CHI lines set additional allowed rotations around bonds, the NBR atom is used for Rosetta to detect neighboring residues. For example, if you set the NBR atom to a carbon on the end of an alkyl chain and then tell rosetta to repack the neighboring residues, it will only find the residues near that atom. The ICOOR_INTERNAL tells Rosetta how to create the 3D shape of the molecule. The last line PDB_ROTAMERS tells Rosetta where to find the additional conformations for this molecule.

---
*1w6y_conformers.pdb*
---

This contains pdb-style 3d coordinates for additional conformations

---
*docking.xml*
---

The protocol to run Rosetta Dock that uses the enzdes constraints to make sure the ligand binds in a catalytically relevant way. Things to note, 1 - You can/should set starting coordinates. I generate the xyz coordinates by averaging the catalytic residue CA xyz coordinates. This starts the docking by placing the ligand at those coordinates.


If you work from Protocols and trace it backwards, the follow protocol is ran... 1st - the constraints from the enzdes file are added to the protein system. Then the ligand is moved so that it's center of mass is at the start from coordinates. Then iterative_dp is ran.... if you locate that mover above, it is the GenericMonteCarlo mover with the mover_name set to dock_pak....tracing that back you will find the dock_pack mover is the name for the ParsedProtocol.... that protocol consists of the 3 moves (predock - a perturbation of the ligand, cstopt - an optimization of the ligand subject to the constraints, repack_wbb - a repack step that allows the backbone to also move). This repeats for the number of cycles 
in the GenericMonteCarlo, the lowest energy is passed to the final repack mover and then the filter allcsts is applied to remove anything with very high constraints.


_____________________________________________________________________
The 4 files are all you need to establish a "model" system. From the input files, you can derive everything you need to model and dock an entire family of proteins in the same family as the model system.
_____________________________________________________________________

---
*1w6y.fasta*
---

Can be derived from the pdb structure using pyrosetta, or other code.

```python
p = pose_from_pdb('dockinginput.pdb') 
p.sequence()
```



```python

```