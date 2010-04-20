xml.instruct!
xml.Response do
  xml.Say("Speak after the beep.")
  xml.Record(:transcribe=>"true", :transcribeCallback=>"/transcription-complete", :maxLength=>"120", :action=>"/goodbye")
  xml.Say("I can't hear you, please try again.")
  xml.Redirect("/record-prompt")
end