Liquid::Template.register_tag('button', Button)
Liquid::Template.register_tag('facebook_share_url', FacebookShareUrl)
Liquid::Template.register_tag('ask_popout', AskPopoutBlock)

class CustomLiquid
  def render_nested(str, context)
    rendered_str = str
    loop do
      masked_template = masked_non_leaf_tags(rendered_str)
      rendered_str = Liquid::Template.parse(masked_template, :error_mode => :strict).render(context)
      break if !masked_template.include?('__TOKEN') # If nothing was masked for that render, we're done
      rendered_str = unmask_tags(rendered_str)
    end

    rendered_str
  end

  private

  # Find every {% that has another {% before the first  %}, and store the index
  def get_mask_indexes(str, forward = true)
    if forward
      open_tokens = ['{%', '{{']
      open_pattern = /\{%|{{/
      close_pattern = /%}|}}/
    else
      open_tokens = ['}%', '}}']
      open_pattern = /\}%|}}/
      close_pattern = /%{|{{/
    end

    indexes = []
    s = StringScanner.new(str)

    loop do
      break if s.scan_until(open_pattern).nil?

      meanwhile_content = s.scan_until(close_pattern)
      if open_tokens.any? { |tok| meanwhile_content&.include?(tok) }
        s.unscan
        indexes << s.pos - 2
      end

      break if s.eos?
    end

    indexes.sort
  end

  def masked_non_leaf_tags(str)
    replace_forward = get_mask_indexes(str)
    replace_backward = get_mask_indexes(str.reverse, false).map { |x| str.size - x - 2 }

    new_str = str
    offset = 0
    tokens_to_replace = ['{%', '{{', '}}', '%}']

    # It's important to sort the indexes so we replace them in order. Otherwise offsets won't work
    (replace_forward + replace_backward).sort.each do |i|
      token_index = tokens_to_replace.find_index(new_str[i+offset..i+offset+1])
      new_str[i+offset..i+offset+1] = "__TOKEN#{token_index}__"
      offset += 8 # The token moves all subsequent tokens along by 8 characters
    end

    new_str
  end

  def unmask_tags(str)
    new_str = str
    tokens_to_replace = ['{%', '{{', '}}', '%}']
    tokens_to_replace.each_with_index do |token, i|
      new_str.gsub!("__TOKEN#{i}__", token)
    end
    new_str
  end
end
