module HomeHelper
  def features
    [
      { title: 'Recruitment', body: '学校側が求める人物像、学力、資格、ポテンシャルが見れる！', icon: 'fa-solid fa-user-plus' },
      { title: 'Research', body: '大学が行っている最先端の研究成果を見れる！', icon: 'fa-solid fa-book-open' },
      { title: 'Chat', body: '教授とチャットをして、志望校選びの参考にしよう！', icon: 'fa-solid fa-comments' },
      { title: 'Free', body: '完全無料で利用することができます！', icon: 'fa-brands fa-creative-commons-nc-jp' },
      { title: 'Security', body: '運営によるパトロールを実施しております。', icon: 'fa-solid fa-eye' },
      { title: 'Next...', body: 'さぁ、未来を拓こう。', icon: 'fa-solid fa-door-open' }
    ]
  end

  def footers
    [
      { title: 'About', link: '#' },
      { title: 'Blog', link: '#' },
      { title: 'Team', link: '#' },
      { title: 'Pricing', link: '#' },
      { title: 'Contact', link: '#' },
      { title: 'Terms', link: '#' }
    ]
  end

  def social_apps
    [
      { title: 'Facebook', icon: 'fa-brands fa-facebook', link: '#' },
      { title: 'Instagram', icon: 'fa-brands fa-instagram', link: '#' },
      { title: 'Twitter', icon: 'fa-brands fa-twitter', link: '#' },
      { title: 'Github', icon: 'fa-brands fa-github', link: 'https://github.com/hulk-higakijin/unifas' },
      { title: 'Dribble', icon: 'fa-brands fa-dribbble', link: '#' }
    ]
  end
end
