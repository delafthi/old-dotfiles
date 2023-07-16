(module plugins.mkdnflow
  {autoload {: mkdnflow}})

(defn config []
  "Configure mkdnflow.nvim"
  ;; Call the setup function
  (mkdnflow.setup
    {:perspective {:priority "current"}
     :bib {:find_in_root true}
     :links {:transform_explicit
             (fn [text] (string.lower (string.gsub text " " "-")))}
     :mappings {:MkdnEnter ["n" "<CR>" ]
                :MkdnTab ["i" "<Tab>"]
                :MkdnSTab ["i" "<S-Tab>"]
                :MkdnNextLink ["n" "<Tab>"]
                :MkdnPrevLink ["n""<S-Tab>"]
                :MkdnNextHeading ["n" "]h"]
                :MkdnPrevHeading ["n" "[h"]
                :MkdnGoBack ["n" "<Bs>"]
                :MkdnGoForward ["n" "<Del>"]
                :MkdnFollowLink false ;; see MkdnEnter
                :MkdnDestroyLink ["n" "<M-CR>"]
                :MkdnTagSpan ["v" "<M-CR>"]
                :MkdnMoveSource false
                :MkdnYankAnchorLink ["n" "ya"]
                :MkdnYankFileAnchorLink ["n" "yfa"]
                :MkdnIncreaseHeading ["n" "+"]
                :MkdnDecreaseHeading ["n" "-"]
                :MkdnToggleToDo [["n" "v"] "<C-Space>"]
                :MkdnNewListItem false
                :MkdnNewListItemBelowInsert ["n" "o"]
                :MkdnNewListItemAboveInsert ["n" "O"]
                :MkdnExtendList false
                :MkdnUpdateNumbering false
                :MkdnTableNextCell false
                :MkdnTablePrevCell false
                :MkdnTableNextRow false
                :MkdnTablePrevRow false
                :MkdnTableNewRowBelow false
                :MkdnTableNewRowAbove false
                :MkdnTableNewColAfter false
                :MkdnTableNewColBefore false
                :MkdnFoldSection false
                :MkdnUnfoldSection false}}))
