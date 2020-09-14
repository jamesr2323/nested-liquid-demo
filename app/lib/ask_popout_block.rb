class AskPopoutBlock < Liquid::Block
  attr_accessor :answers

  def initialize(name, params, tokens)
    @question = params
    super
  end

  def render(context)
    content = super
    <<~HTML
      <div style="Margin: 30px auto;margin-top:30px;margin-bottom:30px; margin-left:0; margin-right:0;box-shadow: 0px 4px 30px #E5E5E5;border-radius: 8px; border: 1px solid #dddddd;">
        <table align="center" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="center" vertical-align="middle" style="font-size:0px;padding-bottom:10px;word-break:break-word;">
              <table role="presentation" style="border-collapse:separate;line-height:100%;" cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td align="center" vertical-align="middle" style="font-size:0px;padding:30px;word-break:break-word;">
                    <table align="center" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td align="center" vertical-align="middle" style="font-size:0px;padding-bottom:10px;word-break:break-word;">
                          <table role="presentation" style="border-collapse:separate;line-height:100%;" cellspacing="0" cellpadding="0" border="0">
                            <tbody>
                              <tr>
                                <td role="presentation" style="border:none;border-radius:4px;cursor:auto;padding:10px 15px;" valign="middle" align="center">
                                  <span style="color:#111;font-size:20px;font-weight:normal;line-height:100%;padding:0;margin:0;text-decoration:none;text-transform:none;font-weight:bold;">
                                      #{@question}
                                  </span>
                                </td>
                              </tr>
                            </tbody>
                          </table>
                        </td>
                      </tr>
                    </table>

                    #{content}
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </div>
    HTML
  end
end