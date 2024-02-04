# SATD Commits Analysis

Supporting sources for analyzing self-admitted technical debt (SATD)
and its correlation with changes in lines, files,
and the delta of unit complexity within a commit.

## Source data

Data extraction was performed using the [SATD GIT Extractor](https://github.com/BambusControl/satd-git-extractor) project.
The tool extracts additional data for the [source dataset](https://github.com/yikun-li/satd-different-sources-data) of another SATD study.[^1]

## Initialize Project

> [!NOTE]
> The following instructions are for Windows using [virtual environment](https://docs.python.org/3/library/venv.html).
> The [Python version](./.python-version) is specified for [PyEnv](https://github.com/pyenv/pyenv).

Initialize Python virtual environment.

```shell
python -m venv env
```

Activate the environment.

```powershell
.\env\Scripts\Activate.ps1
```

Install dependencies.

```shell
pip install -r requirements.txt
```

Now you're ready to use the Jupiter notebook in the [src](./src) directory.

[^1]: Li, Y., Soliman, M. & Avgeriou, P. Automatic identification of self-admitted technical debt from four different sources. Empir Software Eng 28, 65 (2023). https://doi.org/10.1007/s10664-023-10297-9
