# App vs Web

**Note!** The scripts requires a unix-like system (Linux or OSX) and `bash`. (It is also recommended to set `bash` as the default shell of the user.)

## Utilities
**Note!** All scripts are intended for use with only a single device connected over ADB.

### Subject selection
The file `utils/Candidate_subjects.csv` was generated using `utils/generate_candidate_subjects.py` and the Tranco and Google Play lists.  
From this, the 10 subjects were manually selected.  
The file `apks/summary.txt` contains information about the native versions of the subjects and was generated using `utils/generate_summary.sh`.

### Device setup
Use `utils/apps.sh` to (un)install the APKs for all subjects from this folder.  

### Experiment hooks and utilities
The script `utils/before_run.sh` ensures that all experiments are conducted using a consistent device state. (Append `killall` to stop all currently running apps and `clear` to delete all app data.)
Use `utils/tap_text.sh` to click on a UI element with text matching a given pattern through ADB.
Use `utils/clear_cache.sh` to clear the cache (but not the data) of an application.
Use `utils/current_app.sh` and `utils/current_url.sh` to query the currently running native or web app respectively over ADB.
### Experiment data
Use `utils/run_to_csv.py` to aggregate all measurements in a single table. (The output provided in [`raw_results.tar.gz`](https://drive.google.com/file/d/1iNbD2xZZPrcmblFqGKKF6xm_otRTQDEu/view?usp=share_link) was used to to generate `data_analysis/experiment_results`.)

## Experiment
The experiment can be run using `python3 <path to android-runner> experiments/config_<part>.json`.
All files needed by the configuration should be placed in `/var/ar-utils`.

## Plugins
The custom plugins are located in `plugins/`.
To install them, create a symbolic link for each plugin folder inside the android-runner plugin folder (`ln -s plugins/<plugin> <path to android-runner>/AndroidRunner/Plugins/<plugin>`).

## Data Analysis
The data analysis is performed using the [R](https://www.r-project.org/) programming language.
All corresponding scripts are located in `analysis/`.

## Steps
1. Install the requirements (Android SDK for ADB and Systrace, Python 3, Python 2, Bash and GNU utils, R and required packages using `data_analysis/install_packages.R`).
2. Setup device with Android Runner
3. Symbolically link plugins into Android Runner Plugins folder
4. Copy systrace into `/var/ar-utils/`
5. Copy your device's power profile into `/var/ar-utils/power_profiles/` (and update the name in `experiments/config_<part>.json`)
6. Obtain and install apps from list in `apks/summary.txt`
7. Run experiment using `python3 <path to android-runner> experiments/config_<part>.json`
8. Generate CSV using `utils/run_to_csv.py experiments/output/<experiment> >> data_analysis/experiment_results.csv` (Make sure to remove the header from every subsequent run by appending `--no-header` to the command)
9. Run data analysis using `data_analysis/<analysis>.R` (Figures are stored in `data_analysis/plots/`, other results and LaTeX tables are printed to the console.)
