#!/usr/bin/env python

import papis.api
import papis.yaml
import papis.commands.rename
from papis.utils import clean_document_name
from papis.bibtex import ref_cleanup

# Set to true to actually change the ref name
rename_ref = False
library_name = "papers"

docs = papis.api.get_all_documents_in_lib(library_name)

for doc in docs:

    # get a new name formed by:
    #   -  15 characters of the titel
    #   -  The family name of the first author, if any
    #   -  the year
    #
    try:
        new_name_unsafe = "{:.15}-{}-{}".format(
            doc["title"], doc["author_list"][0]["family"], doc["year"]
        )
    except IndexError:
        new_name_unsafe = "{:.15}-{}".format(doc["title"], doc["year"])
    # This new name includes potentially spaces and weird characters, clean it
    # up, to be used as a reference
    clean_name = ref_cleanup(clean_document_name(new_name_unsafe))

    # Print the new name
    print(clean_name)

    if rename_ref:
        # Change the field
        doc["ref"] = clean_name
        doc.save()
