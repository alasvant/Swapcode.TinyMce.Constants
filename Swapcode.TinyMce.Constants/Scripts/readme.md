# Tools needed

You will need Python to scrape table data from TinyMCE web page: https://www.tinymce.com/docs/advanced/editor-control-identifiers/

And powershell to generate the constant classes.

# Scrape table data from web page

Use the PythonTableScaraper.py to scrape the table data from the web page. The script uses `pandas` module which you need to install using `pip install <dependencyname>` + related dependencies.
(try to run the `py PythonTableScraper.py` it will tell you if you are missing dependencies and then use the `pip install dependencyname` to install the missing dependencies)

After you have succesfully installed all the dependent modules you can actually run the `PythonTableScraper.py`. The script scrapes tables from the url that is given to the script.
There should be two tables on the TinyMCE web page. First one includes the toolbar control identifiers and the second has the menubar control identifiers.

To generate CSV files from the web page tables run the following command in the scripts directory:

`py PythonTableScraper.py`
enter url: `https://www.tinymce.com/docs/advanced/editor-control-identifiers/`
enter table number: 1
enter file name: toolbar-identifiers

repeat but enter table number: 2
and filename: menubar-identifiers

Now you have the CSV files that will be used to generate the constant classes.

# Powershell script to generate classes

After you have the CSV source files you can run the powershell script that will generate the constant classes.

Open powershell and navigate to the scripts folder and execute the script:
`.\GenerateClasses.ps1`

Done.