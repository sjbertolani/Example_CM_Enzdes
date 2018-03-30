### Instructions

The modelsysteminputs contains the files that a user will bring. These are a set of enzyme design constraints, a ligand and pdb structure. A user will bring an idealized system and a list of fasta sequences to model

The homologymodelingsetup contains all of the files that are needed/created in the process of taking a FASTA sequence and getting it ready to run homology modeling. In this case, the sequence is the same as the idealized system. But in many use cases, the equivalent files will need to be generated for a different protein sequence.

The dockingsetup contains the files used to run docking. Note the REMARK lines inside of the pdb file. Special flags are used here as well. Also, the docking.xml StartFrom coordinates will be unique to the model that is used for docking and must be calculated for each system that docking will be ran on.