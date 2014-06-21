#= require vender/jquery
#= require vender/bootstrap

$ ->

  ### Enable Twitter Bootstrap Tooltips ###
  $('[data-toggle="tooltip"]').tooltip()

  ### Enable Disqus Comments ###
  disqus_shortname = "clutteredcode"
  (->
    s = document.createElement("script")
    s.async = true
    s.type = "text/javascript"
    s.src = "//" + disqus_shortname + ".disqus.com/count.js"
    (document.getElementsByTagName("HEAD")[0] or document.getElementsByTagName("BODY")[0]).appendChild s
  )()
