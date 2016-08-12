PuppetLint.new_check(:top_scope_facts) do
  def check
    tokens.select { |x| x.type == :VARIABLE}.each do |token|
      if token.value.match(/^::/)
        notify :warning, {
          :message => 'top scope fact instead of facts hash',
          :line    => token.line,
          :column  => token.column,
          :token   => token,
        }
      end
    end
  end


  def fix(problem)
    problem[:token].value = "facts['" + problem[:token].value.sub(/^::/, '') + "']"
  end
end
