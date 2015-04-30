
var
  stir $ require :stir-template

var
  (object~ html head title body meta script link div a span) stir

var
  line $ \ (text)
    return $ div null text

= module.exports $ \ (data)
  return $ stir.render
    stir.doctype
    html null
      head null
        title null ":React Lite Dropdown"
        meta $ object (:charset :utf-8)
        script $ object (:src data.main) (:defer true)
      body null
        div
          object (:class :intro)
          div (object (:class :title)) ":demo of Lite Layered Components"
          line ":Add your own style in your projects."
          div null
            span null ":Read more at "
            a
              object (:href :http://github.com/teambition/react-lite-layered)
              , :github.com/teambition/react-lite-layered
            span null :.
        div
          object (:class :demo)
