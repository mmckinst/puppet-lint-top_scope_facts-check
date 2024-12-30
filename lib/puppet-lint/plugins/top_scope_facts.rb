PuppetLint.new_check(:top_scope_facts) do
  TOP_SCOPE_FACTS_VAR_TYPES = Set[:VARIABLE, :UNENC_VARIABLE]
  def check
    whitelist = ['trusted', 'facts'] + (PuppetLint.configuration.top_scope_variables || [])
    whitelist = whitelist.join('|')
    tokens.select { |x| TOP_SCOPE_FACTS_VAR_TYPES.include?(x.type) }.each do |token|
      next unless token.value.match(/^::/)
      next if token.value.match(/^::(#{whitelist})\[?/)
      next if token.value =~ /^::[a-z0-9_][a-zA-Z0-9_]+::/

      notify :warning, {
        :message => 'top scope fact instead of facts hash',
        :line    => token.line,
        :column  => token.column,
        :token   => token,
      }
    end
  end

  def fix(problem)
    problem[:token].value = "facts['" + problem[:token].value.sub(/^::/, '') + "']"
  end
end
