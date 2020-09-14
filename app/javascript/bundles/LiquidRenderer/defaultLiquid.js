export default `
<p>
    Dear {{ first_name }},<br /><br />

    This is really important.<br />

{% ask_popout What do you want? %}
    {% button #ccc https://www.google.com?guid={{guid}} More Badgers %}
    {% button green https://www.google.com Fun for {{first_name}}  %}
    {% button red https://www.google.com Save our {{ top_issue | default: 'NHS' }}  %}
{% endask_popout %}

PS: If you don't mind, would you share on Facebook?

{% button #4267B2 {% facebook_share_url https://www.google.com %} Share Now %}

</p>
`