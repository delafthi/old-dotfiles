#!/usr/bin/env python

import papis.api
import papis.yaml
import papis.commands.rename
from papis.utils import clean_document_name
from papis.bibtex import ref_cleanup

rename_ref = True
library_name = "papers"

docs = papis.api.get_all_documents_in_lib(library_name)

for doc in docs:

    # get a new name formed by:
    #   -  10 characters of the author field
    #   -  10 characters of the title field
    #   -  the year, if any
    #
    try:
        new_name_unsafe = "{:.15}-{}-{}".format(
            doc["title"], doc["author_list"][0]["family"], doc["year"]
        )
    except IndexError:
        new_name_unsafe = "{:.15}-{}".format(doc["title"], doc["year"])
    # This new name includes potentially spaces and weird characters
    # papis ships with a function to clean it up
    clean_name = ref_cleanup(clean_document_name(new_name_unsafe))

    print(clean_name)

    if rename_ref:

        doc["ref"] = clean_name
        doc.save()
