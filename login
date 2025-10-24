# Creating a single-file interactive HTML (Login/SignUp animation) and saving it to /mnt/data
html_content = r"""
<!doctype html>
<html lang="id">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Login / SignUp Animation</title>
<style>
  :root{
    --bg:#0f1724;
    --card:#0b1220;
    --accent:#6ee7b7;
    --soft:#94a3b8;
    --glass: rgba(255,255,255,0.04);
  }
  *{box-sizing:border-box;font-family:Inter,ui-sans-serif,system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial;}
  body{
    margin:0;
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    background:
      radial-gradient(600px 400px at 10% 20%, rgba(110,231,183,0.06), transparent 10%),
      radial-gradient(500px 350px at 90% 80%, rgba(99,102,241,0.05), transparent 10%),
      linear-gradient(180deg,var(--bg), #071022 140%);
    color:#e6eef8;
  }

  .wrap{
    width:920px;
    max-width:92vw;
    height:560px;
    background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
    border-radius:18px;
    box-shadow: 0 10px 40px rgba(2,6,23,0.7);
    display:flex;
    overflow:hidden;
    position:relative;
    border:1px solid rgba(255,255,255,0.03);
  }

  /* Left visual panel */
  .visual{
    width:48%;
    min-width:300px;
    background: linear-gradient(135deg, rgba(110,231,183,0.06), rgba(99,102,241,0.05));
    padding:28px;
    position:relative;
    display:flex;
    flex-direction:column;
    gap:18px;
    align-items:flex-start;
    justify-content:center;
  }
  .brand{
    display:flex;
    gap:12px;
    align-items:center;
    z-index:2;
  }
  .logo{
    width:56px;height:56px;border-radius:12px;background:linear-gradient(135deg,var(--accent), #60a5fa);
    display:grid;place-items:center;font-weight:700;color:#052018;box-shadow:0 6px 18px rgba(102,126,234,0.12);
  }
  .brand h1{font-size:20px;margin:0;letter-spacing:0.2px;}
  .brand p{margin:0;color:var(--soft);font-size:13px;}

  /* decorative floating shapes */
  .bubble{
    position:absolute;border-radius:999px;opacity:0.12;filter:blur(18px);
  }
  .b1{width:160px;height:160px;left:20px;top:20px;background:linear-gradient(90deg,#7c3aed,#60a5fa);}
  .b2{width:220px;height:220px;right:20px;bottom:40px;background:linear-gradient(90deg,#06b6d4,#7c3aed);}
  .wave{
    position:absolute;left:-40px;bottom:-40px;width:220px;height:220px;opacity:0.06;transform:rotate(15deg);
  }

  /* Animated fish (SVG) */
  .fish-wrap{width:100%;display:flex;align-items:center;justify-content:center;margin-top:8px;z-index:2}
  .fish{
    width:210px;height:210px;transform-origin:center;animation: swim 4.6s linear infinite;
    filter: drop-shadow(0 8px 18px rgba(2,6,23,0.5));
  }
  @keyframes swim{
    0%{transform: translateX(-10px) translateY(0) rotate(-6deg);}
    25%{transform: translateX(8px) translateY(-8px) rotate(6deg);}
    50%{transform: translateX(-10px) translateY(6px) rotate(-4deg);}
    75%{transform: translateX(6px) translateY(-6px) rotate(6deg);}
    100%{transform: translateX(-10px) translateY(0) rotate(-6deg);}
  }

  .tagline{font-size:14px;color:var(--soft);max-width:240px;line-height:1.3;}
  .cta{margin-top:8px;padding:10px 14px;border-radius:10px;background:linear-gradient(90deg, rgba(110,231,183,0.12), rgba(96,165,250,0.06));border:1px solid rgba(110,231,183,0.06);font-weight:600;color:var(--accent);cursor:pointer;}

  /* Right form panel */
  .form-area{
    width:52%;
    padding:34px 36px;
    display:flex;
    flex-direction:column;
    gap:16px;
    justify-content:center;
    position:relative;
    background: linear-gradient(180deg, rgba(255,255,255,0.015), transparent 40%);
  }
  .toggle{
    display:flex;
    gap:8px;
    align-items:center;
    background:var(--glass);
    padding:6px;
    border-radius:999px;
    width:max-content;
  }
  .toggle button{
    background:transparent;border:0;padding:10px 16px;border-radius:999px;color:var(--soft);cursor:pointer;font-weight:600;
  }
  .toggle button.active{
    color:#052018;background:linear-gradient(90deg,var(--accent),#60a5fa);box-shadow:0 8px 22px rgba(99,102,241,0.08);
  }

  .card{
    margin-top:6px;background:linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
    border-radius:14px;padding:22px;box-shadow: inset 0 1px 0 rgba(255,255,255,0.02);
    border:1px solid rgba(255,255,255,0.03);
  }
  .form-row{display:flex;flex-direction:column;gap:10px;margin-bottom:8px;}
  label{font-size:13px;color:var(--soft);display:block;}
  input{padding:12px 14px;border-radius:10px;border:1px solid rgba(255,255,255,0.04);background:transparent;color:inherit;outline:none;font-size:14px;}
  .actions{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-top:6px;}
  .primary{padding:10px 14px;border-radius:10px;border:0;background:linear-gradient(90deg,var(--accent),#60a5fa);color:#052018;font-weight:700;cursor:pointer;box-shadow:0 8px 24px rgba(110,231,183,0.08);}

  /* small helper */
  .socials{display:flex;gap:10px;margin-top:12px}
  .socials button{padding:8px 10px;border-radius:10px;border:1px solid rgba(255,255,255,0.03);background:transparent;color:var(--soft);cursor:pointer;font-weight:600}

  /* transition when switching panes */
  .pane{position:relative;overflow:hidden;min-height:260px;}
  .pane > .inside{transition: transform 650ms cubic-bezier(.2,.9,.23,1.02), opacity 400ms ease; transform-origin:left top;}
  .pane.signup .inside{transform: translateX(0); opacity:1;}
  .pane.login .inside{transform: translateX(0); opacity:1;}

  .pane.slide-out{animation: slideOut 520ms forwards;}
  .pane.slide-in{animation: slideIn 520ms forwards;}
  @keyframes slideOut{
    0%{transform:translateX(0);opacity:1;}
    100%{transform:translateX(-18px);opacity:0;}
  }
  @keyframes slideIn{
    0%{transform:translateX(18px);opacity:0;}
    100%{transform:translateX(0);opacity:1;}
  }

  /* subtle floating glass */
  .glass-card{position:absolute;right:20px;top:18px;background:rgba(255,255,255,0.02);backdrop-filter: blur(6px);padding:8px 10px;border-radius:12px;border:1px solid rgba(255,255,255,0.03);font-size:13px;color:var(--soft)}
  footer{position:absolute;left:18px;bottom:14px;font-size:12px;color:var(--soft)}
  /* responsive */
  @media (max-width:820px){
    .wrap{flex-direction:column;height:auto;padding-bottom:18px;}
    .visual,.form-area{width:100%}
    .visual{order:2;padding-top:18px;padding-bottom:6px;}
    .form-area{order:1;padding-top:22px;padding-bottom:6px;}
    .fish{width:160px;height:160px}
  }
</style>
</head>
<body>
<div class="wrap" id="app">
  <div class="visual" aria-hidden="true">
    <div class="brand">
      <div class="logo">AW</div>
      <div>
        <h1>AwesomeWave</h1>
        <p>UI micro-animation — Login &amp; Signup</p>
      </div>
    </div>

    <div class="fish-wrap" role="img" aria-label="animated fish">
      <!-- Cute fish SVG -->
      <svg class="fish" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <linearGradient id="g1" x1="0" x2="1">
            <stop offset="0" stop-color="#6ee7b7"/>
            <stop offset="1" stop-color="#60a5fa"/>
          </linearGradient>
        </defs>
        <g transform="translate(10,10)">
          <ellipse cx="90" cy="90" rx="50" ry="36" fill="url(#g1)"/>
          <path d="M40 90 C20 70, 6 100, 40 110 Z" fill="#60a5fa"/>
          <circle cx="115" cy="80" r="6" fill="#052018"/>
          <path d="M130 60 Q150 80 130 100" stroke="#60a5fa" stroke-width="6" fill="none" stroke-linecap="round"/>
          <g transform="translate(60,110) rotate(20)">
            <path d="M0 0 C10 -6,16 -6,28 0 C16 6,10 6,0 0 Z" fill="#8b5cf6"/>
          </g>
        </g>
      </svg>
    </div>

    <p class="tagline">Cepet masuk, biar gak ketinggalan. Animasi kecil, vibes besar. Designed to delight with micro-interactions.</p>
    <button class="cta" id="demoAction">Preview Demo</button>

    <div class="bubble b1"></div>
    <div class="bubble b2"></div>
    <svg class="wave" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
      <path d="M0 120 C40 80,80 140,120 110 C160 80,200 140,240 120" stroke="#60a5fa" stroke-width="10" fill="none" stroke-linecap="round" />
    </svg>
  </div>

  <div class="form-area" role="main">
    <div class="glass-card">Beta • Animated</div>
    <div style="display:flex;align-items:center;justify-content:space-between;">
      <div>
        <h2 style="margin:0">Welcome</h2>
        <p style="margin:6px 0 0;color:var(--soft);font-size:13px">Masuk atau daftar untuk mulai eksplor.</p>
      </div>
      <div class="toggle" role="tablist" aria-label="switch forms">
        <button id="btnLogin" class="active" role="tab" aria-selected="true">Login</button>
        <button id="btnSignup" role="tab">Sign Up</button>
      </div>
    </div>

    <div class="card">
      <div id="paneContainer" class="pane login" aria-live="polite">
        <div class="inside" id="loginPane">
          <div class="form-row">
            <label for="email">Email</label>
            <input id="email" placeholder="name@contoh.com" type="email" />
          </div>
          <div class="form-row">
            <label for="pass">Password</label>
            <input id="pass" placeholder="••••••••" type="password" />
          </div>

          <div class="actions">
            <div style="display:flex;gap:8px;align-items:center;">
              <input id="remember" type="checkbox" />
              <label for="remember" style="font-size:13px;color:var(--soft);">Ingat saya</label>
            </div>
            <a href="#" style="font-size:13px;color:var(--soft);text-decoration:none">Lupa password?</a>
          </div>

          <div style="display:flex;gap:10px;margin-top:12px;align-items:center;">
            <button class="primary" id="loginBtn">Masuk</button>
            <button class="socials" id="loginAnimBtn" style="background:none;border:0;padding:0;margin-left:auto;">✨ Preview anim</button>
          </div>
        </div>

        <div class="inside" id="signupPane" style="display:none;">
          <div class="form-row">
            <label for="name">Nama</label>
            <input id="name" placeholder="Nama lengkap" type="text" />
          </div>
          <div class="form-row">
            <label for="semail">Email</label>
            <input id="semail" placeholder="name@contoh.com" type="email" />
          </div>
          <div class="form-row">
            <label for="spass">Password</label>
            <input id="spass" placeholder="Buat password" type="password" />
          </div>

          <div style="display:flex;gap:10px;margin-top:10px;align-items:center;">
            <button class="primary" id="signupBtn">Daftar</button>
            <div style="margin-left:auto;color:var(--soft);font-size:13px">Atau daftar pakai</div>
          </div>

          <div class="socials" style="margin-top:12px;">
            <button>Google</button>
            <button>GitHub</button>
            <button>Twitter</button>
          </div>
        </div>

      </div>
    </div>

    <footer>© AwesomeWave • 2025</footer>
  </div>
</div>

<script>
  // Simple JS to mimic the animation from an example Login/SignUp micro-interaction
  const btnLogin = document.getElementById('btnLogin');
  const btnSignup = document.getElementById('btnSignup');
  const loginPane = document.getElementById('loginPane');
  const signupPane = document.getElementById('signupPane');
  const paneContainer = document.getElementById('paneContainer');
  const demoAction = document.getElementById('demoAction');
  const loginAnimBtn = document.getElementById('loginAnimBtn');

  function switchTo(which){
    // toggle active classes
    btnLogin.classList.toggle('active', which === 'login');
    btnSignup.classList.toggle('active', which === 'signup');

    // run slide animations
    if(which === 'signup'){
      // show signup
      loginPane.style.display = 'none';
      signupPane.style.display = 'block';
      paneContainer.classList.remove('login');
      paneContainer.classList.add('signup','slide-in');
      setTimeout(()=>paneContainer.classList.remove('slide-in'),600);
    } else {
      signupPane.style.display = 'none';
      loginPane.style.display = 'block';
      paneContainer.classList.remove('signup');
      paneContainer.classList.add('login','slide-in');
      setTimeout(()=>paneContainer.classList.remove('slide-in'),600);
    }
  }

  btnLogin.addEventListener('click', ()=>switchTo('login'));
  btnSignup.addEventListener('click', ()=>switchTo('signup'));

  // micro animation: click preview will show a quick "success" spark then shake
  function flashSuccess(el){
    const spark = document.createElement('div');
    spark.textContent = "✔";
    spark.style.position='absolute';
    spark.style.left='50%';
    spark.style.top='20%';
    spark.style.transform='translate(-50%,-50%)';
    spark.style.background='linear-gradient(90deg,var(--accent),#60a5fa)';
    spark.style.color='#052018';
    spark.style.padding='12px 14px';
    spark.style.borderRadius='999px';
    spark.style.boxShadow='0 12px 30px rgba(110,231,183,0.12)';
    spark.style.fontWeight='700';
    spark.style.zIndex=9999;
    document.body.appendChild(spark);
    setTimeout(()=>{spark.style.transition='all 360ms ease';spark.style.opacity=0; spark.style.transform='translate(-50%,-80%) scale(0.85)';},600);
    setTimeout(()=>spark.remove(),1100);
  }

  demoAction.addEventListener('click', ()=>{
    // small bounce + swim acceleration
    const fish = document.querySelector('.fish');
    fish.style.animation = 'swim 1.1s linear 0s 3';
    flashSuccess();
    setTimeout(()=>fish.style.animation='swim 4.6s linear infinite', 1400);
  });

  loginAnimBtn.addEventListener('click', ()=>{
    // pretend login success micro-flow with tiny confetti and form transform
    const btn = document.getElementById('loginBtn');
    btn.disabled = true;
    btn.textContent = 'Checking...';
    setTimeout(()=>{
      btn.textContent = 'Welcome!';
      btn.style.transform = 'translateY(-6px) scale(1.02)';
      flashSuccess(btn);
      document.querySelector('.fish').style.transform += ' translateX(8px)';
    },900);
    setTimeout(()=>{btn.disabled=false;btn.textContent='Masuk';btn.style.transform='';},1800);
  });

  // small accessibility: press Enter to trigger login preview when focused in password
  document.getElementById('pass').addEventListener('keydown', (e)=>{
    if(e.key === 'Enter'){ loginAnimBtn.click(); }
  });

  // add gentle parallax on mouse move for a bit of depth
  const wrap = document.querySelector('.wrap');
  wrap.addEventListener('mousemove', (e)=>{
    const r = wrap.getBoundingClientRect();
    const x = (e.clientX - r.left) / r.width - 0.5;
    const y = (e.clientY - r.top) / r.height - 0.5;
    document.querySelector('.visual').style.transform = `translate3d(${x*8}px,${y*4}px,0)`;
    document.querySelector('.form-area').style.transform = `translate3d(${x*-6}px,${y*-3}px,0)`;
  });
  wrap.addEventListener('mouseleave', ()=>{ document.querySelector('.visual').style.transform=''; document.querySelector('.form-area').style.transform=''; });

  // initial tiny entrance
  window.addEventListener('load', ()=>{
    paneContainer.classList.add('slide-in');
    setTimeout(()=>paneContainer.classList.remove('slide-in'),700);
  });

</script>
</body>
</html>
"""

# Write file
path = "/mnt/data/login_signup_animation.html"
with open(path, "w", encoding="utf-8") as f:
    f.write(html_content)

# Provide a user-visible link as instructed by the tool guidelines
path
