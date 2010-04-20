xml.instruct!
xml.Response do
  xml.Say("Welcome to Babelio. You can speak to me in English, and I will send you a translation via text message.")
  xml.Say("In the future I may support more languages.")
  xml.Redirect("/record-prompt")
end