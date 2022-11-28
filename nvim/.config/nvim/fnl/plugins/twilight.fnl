(module plugins.twilight
  {autoload {nordic-palette nordic.palette
             : twilight}})

(defn config []
  "Configure twilight.nvim"
  (let [c nordic-palette]
    ;; Call the setup function
    (twilight.setup
      {:dimming
        {:alpha 1.0
         :color [ c.bright_black]}
       :context 10})))
