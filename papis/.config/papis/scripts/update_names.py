#!/usr/bin/env python

import papis.api
import papis.yaml
import papis.commands.rename
from papis.utils import clean_document_name

import shutil
import os

rename_files = True
library_name = "papers"

docs = papis.api.get_all_documents_in_lib(library_name)

for doc in docs:

    # get a new name formed by:
    #   -  20 characters of the title
    #   -  The family name of the first author, if any
    #   -  the year
    #
    try:
        new_name_unsafe = "{:.20}-{}-{}".format(
            doc["title"], doc["author_list"][0]["family"], doc["year"]
        )
    except IndexError:
        new_name_unsafe = "{:.20}_{}".format(doc["title"], doc["year"])
    # This new name includes potentially spaces and weird characters, clean it
    # up to be used as file/folder name.
    clean_name = clean_document_name(new_name_unsafe)

    # Print the name
    print(clean_name)

    # Rename the documents in papis
    papis.commands.rename.run(doc, clean_name, True)

    # Get a list of all files
    files = doc.get_files()
    if rename_files and files:
        # Save the original file name
        original_file = files[0]

        if not files:
            continue

        # Create the new file name
        clean_name = clean_name + ".pdf"
        new_file = os.path.join(os.path.dirname(original_file), clean_name)

        print(original_file, " -> ", new_file)

        if not original_file == new_file:
            # Move the new file to its location and save it in the files field
            shutil.move(original_file, new_file)
        doc["files"] = [clean_name]
        doc.save()
