(module plugins.headlines
  {autoload {: headlines}})

(defn config []
  "Configure headlines.nvim"
  ;; Call the setup function
  (headlines.setup
    {:markdown {:fat_headlines false}
     :rmd {:fat_headlines false}
     :norg {:fat_headlines false}
     :org {:fat_headlines false}}))
