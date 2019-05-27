PuppetLint.new_check(:top_scope_facts) do
  TOP_SCOPE_FACTS_VAR_TYPES = Set[:VARIABLE, :UNENC_VARIABLE]
  def check
    whitelist = ['trusted', 'facts'] + (PuppetLint.configuration.top_scope_variables || [])
    whitelist = whitelist.join('|')
    tokens.select { |x| TOP_SCOPE_FACTS_VAR_TYPES.include?(x.type) }.each do |token|
      if token.value.match(/^::/) and not token.value.match(/^::(#{whitelist})\[?/)
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
    # This probably should never occur, but if it does then bail out:
    raise PuppetLint::NoFix if problem[:token].raw and problem[:token].value != problem[:token].raw

    problem[:token].value = "facts['" + problem[:token].value.sub(/^::/, '') + "']"
    problem[:token].raw = problem[:token].value unless problem[:token].raw.nil?
  end
end
