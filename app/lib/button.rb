class Button < Liquid::Tag
  def initialize(tag_name, args, tokens)
     super
     @color = args.split(' ')[0]
     @url = args.split(' ')[1]
     @text = args.split(' ')[2..-1].join(' ')
  end

  def render(context)
    <<~HTML
      <center><div style="margin-top: 5px; margin-bottom: 5px;"><!--[if mso]>
        <v:rect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="#{@url}" style="height:50px;v-text-anchor:middle;width:200px;" stroke="f" fillcolor="#{@color}">
          <w:anchorlock/>
          <center>
        <![endif]-->
            <a href="#{@url}" style="background-color:#{@color};color:#ffffff;display:inline-block;font-family:sans-serif;font-size:15px;font-weight:bold;line-height:50px;text-align:center;text-decoration:none;width:200px;-webkit-text-size-adjust:none;">#{@text}</a>
        <!--[if mso]>
          </center>
        </v:rect>
      <![endif]--></div></center>
      HTML
  end
end