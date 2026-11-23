require 'irb/completion'

IRB.conf[:SAVE_HISTORY] = 1_000
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.irb_history')

IRB.conf[:PROMPT][:CUSTOM] = {
  PROMPT_I: "#{RUBY_VERSION}> ",
  PROMPT_N: "#{RUBY_VERSION}> ",
  PROMPT_S: nil,
  PROMPT_C: ' ?> ',
  RETURN: " => %s\n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM
