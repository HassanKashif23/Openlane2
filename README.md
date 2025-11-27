# Openlane2

## APR flow using Openlane2


This is a simple step-by-step guide to run the OpenLane2 Automated Place & Route (APR) flow.

### 1. Setup Environment
Move to that folder where your openlane2 is installed, like

=cd OpenLane2

Enter Nix shell (OpenLane2 uses Nix) through the terminal by typing:

=nix-shell

After nix-shell is invoked the terminal command lien will look like this:

[nix-shell:~/openlane2]$ 

Create your design folder, e.g., Multiplier:

=mkdir ~/openlane2/designs/Multiplier

=cd ~/openlane2/designs/Multiplier

### 2. Prepare Design Files
Place your RTL Verilog files here (e.g., mult.v).
Optional: create SDC constraints (timing targets) in mult.sdc or pin constraint file.

### 3. Create config.json

You can create a json file using nano like this:

=nano config.json

It will open an editor on the terminal where you can write your config json script which i have added in my repo you can check there.
You can also use VSCode for writing design, config and constraint files.

### 4. Run OpenLane2 Flow

Run the full flow with your configuration:

=openlane config.json 

if you uses the above command then openlane will create a run directory with a default naming.
But you can name the directory as you wish by running the below command on the terminal

=openlane config.json --run-tag 200MHz

here --run-tag creates the name tag for the directory and 200Mhz is the directory name.
By using this you can keep different runs separate.

All the Output will be in:
runs/200MHz/ folder

OpenLane2 runs all steps:
Verilator linting
Synthesis (Yosys)
Placement & routing (APR)
Timing checks (STA)

### 5. Check Results

GDS / DEF / LEF files: runs/200MHz/final/
Timing report: runs/200MHz/reports/
Log files: runs/200MHz/01-verilator-lint/, runs/300MHz/08-checker-yosyssynthchecks/ etc.

The most important reports are timing reports for which you have to look for STA_post_pnr named file, the name of this can slightly change, like in my runs it is "54-openroad-stapostpnr".
Go inside this folder and you will find a "summary.rpt" file which basically is a summary of the Hold and setup on all the corners.

### 6. Debug Common Issues
These issues which I faced

Verilator warnings → fix width/shift mismatches in RTL.
Yosys errors → check unsupported constructs in Verilog.
STA setup violations → add pipeline registers or reduce clock frequency.
