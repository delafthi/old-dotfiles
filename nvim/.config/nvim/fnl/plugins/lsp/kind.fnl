(module plugins.lsp.kind)

(def- icons
  {:Class ""
   :Color ""
   :Constant ""
   :Constructor ""
   :Enum ""
   :EnumMember ""
   :Event ""
   :Field ""
   :File ""
   :Folder ""
   :Function "󰊕"
   :Interface ""
   :Keyword ""
   :Method ""
   :Module "󰕳"
   :Operator ""
   :Property ""
   :Reference ""
   :Snippet ""
   :Struct ""
   :Text ""
   :TypeParameter ""
   :Unit ""
   :Value ""
   :Variable ""})


(defn cmp-format [entry item shorts]
  "Format completion entry"
  (when (. icons item.kind)
    (tset item :kind (. icons item.kind)))
  (tset item :menu (. shorts entry.source.name))
  item)
