def layout(template)
  erb template, :layout => !env['HTTP_X_PJAX']
end
