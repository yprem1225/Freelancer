<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WorkPort — Hire Skilled Freelancers or Find Dream Projects</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Outfit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --blue: #2563eb;
            --blue2: #1d4ed8;
            --blue3: #3b82f6;
            --bluelt: #eff6ff;
            --cyan: #06b6d4;
            --cyanlt: #ecfeff;
            --dark: #060d1f;
            --dark2: #0c1a3a;
            --g50: #f8fafc;
            --g100: #f1f5f9;
            --g200: #e2e8f0;
            --g300: #cbd5e1;
            --g400: #94a3b8;
            --g500: #64748b;
            --g600: #475569;
            --g700: #334155;
            --g800: #1e293b;
            --ok: #10b981;
            --oklt: #ecfdf5;
            --amber: #f59e0b;
            --amberlt: #fffbeb;
            --rs: 10px;
            --r: 14px;
            --rl: 20px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'Outfit', sans-serif;
            background: #fff;
            color: var(--g800);
            overflow-x: hidden;
        }

        h1, h2, h3, h4, h5 { font-family: 'Syne', sans-serif; }

        a { text-decoration: none; color: inherit; }

        /* ── TOPBAR ── */
        .topbar {
            position: fixed; top: 0; left: 0; right: 0; z-index: 999;
            height: 68px;
            display: flex; align-items: center;
            padding: 0 6%;
            background: rgba(255,255,255,0.92);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--g200);
            transition: box-shadow .3s;
        }
        .topbar.sc { box-shadow: 0 2px 20px rgba(0,0,0,.07); }

        .logo { display: flex; align-items: center; gap: 9px; }
        .logo-txt { font-family: 'Syne', sans-serif; font-size: 1.5rem; font-weight: 800; }
        .logo-txt .w { color: var(--g800); }
        .logo-txt .p { color: var(--blue); }

        .topbar-nav { margin-left: 40px; display: flex; gap: 6px; }
        .topbar-nav a { font-size: 14px; font-weight: 500; color: var(--g500); padding: 6px 12px; border-radius: var(--rs); transition: all .18s; }
        .topbar-nav a:hover { color: var(--blue); background: var(--bluelt); }

        .topbar-right { margin-left: auto; display: flex; align-items: center; gap: 10px; }
        .btn-ghost { padding: 8px 18px; border: 1.5px solid var(--g200); border-radius: var(--rs); font-size: 14px; font-weight: 600; color: var(--g600); transition: all .18s; cursor: pointer; background: #fff; }
        .btn-ghost:hover { border-color: var(--blue); color: var(--blue); background: var(--bluelt); }
        .btn-solid { padding: 8px 18px; background: var(--blue); border: none; border-radius: var(--rs); font-size: 14px; font-weight: 600; color: #fff; transition: all .18s; cursor: pointer; }
        .btn-solid:hover { background: var(--blue2); }

        /* ── HERO ── */
        .hero {
            min-height: 100vh;
            background: linear-gradient(160deg, #f0f7ff 0%, #fafcff 50%, #f0fdf9 100%);
            display: flex; align-items: center;
            padding: 100px 6% 60px;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute; top: -120px; right: -80px;
            width: 700px; height: 700px;
            background: radial-gradient(circle, rgba(37,99,235,.08) 0%, transparent 70%);
            border-radius: 50%;
        }
        .hero::after {
            content: '';
            position: absolute; bottom: -80px; left: -60px;
            width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(6,182,212,.07) 0%, transparent 70%);
            border-radius: 50%;
        }

        .hero-inner {
            max-width: 1200px; margin: 0 auto; width: 100%;
            display: grid; grid-template-columns: 1fr 1fr; gap: 60px; align-items: center;
            position: relative; z-index: 1;
        }

        .hero-badge {
            display: inline-flex; align-items: center; gap: 7px;
            background: var(--bluelt); border: 1px solid rgba(37,99,235,.2);
            color: var(--blue); font-size: 12px; font-weight: 700;
            padding: 5px 12px; border-radius: 100px;
            margin-bottom: 22px;
            letter-spacing: .3px;
            animation: fadeUp .6s ease both;
        }
        .hero-badge .dot { width: 6px; height: 6px; background: var(--blue); border-radius: 50%; animation: pulse 2s infinite; }

        .hero h1 {
            font-size: clamp(2.4rem, 5vw, 3.8rem);
            font-weight: 800;
            line-height: 1.12;
            color: var(--dark2);
            margin-bottom: 22px;
            animation: fadeUp .6s .1s ease both;
        }

        .hero h1 .accent { color: var(--blue); position: relative; }
        .hero h1 .accent::after {
            content: '';
            position: absolute; bottom: -4px; left: 0; right: 0; height: 3px;
            background: linear-gradient(90deg, var(--blue), var(--cyan));
            border-radius: 2px;
        }

        .hero-sub {
            font-size: 17px; line-height: 1.7; color: var(--g500);
            max-width: 480px; margin-bottom: 36px;
            animation: fadeUp .6s .2s ease both;
        }

        .hero-btns {
            display: flex; gap: 14px; flex-wrap: wrap;
            margin-bottom: 50px;
            animation: fadeUp .6s .3s ease both;
        }

        .cta-hire {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 14px 28px;
            background: var(--blue); color: #fff;
            border-radius: var(--r); font-size: 15px; font-weight: 700;
            box-shadow: 0 8px 24px rgba(37,99,235,.3);
            transition: all .2s;
        }
        .cta-hire:hover { background: var(--blue2); transform: translateY(-2px); box-shadow: 0 12px 32px rgba(37,99,235,.4); }

        .cta-work {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 14px 28px;
            background: #fff; color: var(--g700);
            border: 2px solid var(--g200); border-radius: var(--r);
            font-size: 15px; font-weight: 700;
            transition: all .2s;
        }
        .cta-work:hover { border-color: var(--blue); color: var(--blue); transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,.07); }

        .hero-stats {
            display: flex; gap: 32px;
            animation: fadeUp .6s .4s ease both;
        }
        .hero-stat .num { font-family: 'Syne', sans-serif; font-size: 1.6rem; font-weight: 800; color: var(--dark2); }
        .hero-stat .lbl { font-size: 13px; color: var(--g400); margin-top: 2px; }

        /* Hero visual side */
        .hero-visual {
            display: flex; flex-direction: column; gap: 16px;
            animation: fadeUp .6s .2s ease both;
        }

        .hv-card {
            background: #fff;
            border: 1.5px solid var(--g200);
            border-radius: var(--rl);
            padding: 18px 20px;
            box-shadow: 0 4px 24px rgba(0,0,0,.06);
        }

        .hv-card-top { display: flex; align-items: center; gap: 12px; margin-bottom: 12px; }
        .hv-avatar { width: 44px; height: 44px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 16px; color: #fff; flex-shrink: 0; }
        .hv-name { font-weight: 700; font-size: 14px; color: var(--g800); }
        .hv-role { font-size: 12px; color: var(--g400); }

        .hv-stars { color: var(--amber); font-size: 13px; display: flex; gap: 2px; }
        .hv-tags { display: flex; flex-wrap: wrap; gap: 6px; }
        .hv-tag { font-size: 11px; font-weight: 600; padding: 3px 10px; border-radius: 100px; background: var(--bluelt); color: var(--blue); }

        .hv-small { display: flex; gap: 12px; }
        .hv-mini {
            flex: 1; background: #fff; border: 1.5px solid var(--g200);
            border-radius: var(--r); padding: 14px 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }
        .hv-mini-icon { width: 34px; height: 34px; border-radius: 9px; display: flex; align-items: center; justify-content: center; font-size: 15px; margin-bottom: 8px; }
        .hv-mini .val { font-family: 'Syne', sans-serif; font-size: 1.2rem; font-weight: 800; color: var(--dark2); }
        .hv-mini .key { font-size: 11px; color: var(--g400); margin-top: 2px; }

        .hv-job {
            background: linear-gradient(135deg, var(--dark2), #162550);
            color: #fff;
            border-radius: var(--rl);
            padding: 20px;
        }
        .hv-job-title { font-family: 'Syne', sans-serif; font-weight: 700; font-size: 15px; margin-bottom: 6px; }
        .hv-job-meta { font-size: 12px; color: rgba(255,255,255,.55); margin-bottom: 14px; }
        .hv-job-bottom { display: flex; align-items: center; justify-content: space-between; }
        .hv-budget { font-size: 18px; font-weight: 800; color: #fff; }
        .hv-apply { padding: 7px 16px; background: var(--blue); border-radius: 8px; font-size: 12px; font-weight: 700; color: #fff; cursor: pointer; border: none; transition: background .18s; }
        .hv-apply:hover { background: var(--blue3); }

        /* ── SECTION COMMONS ── */
        .section { padding: 90px 6%; }
        .section-inner { max-width: 1200px; margin: 0 auto; }
        .section-header { text-align: center; margin-bottom: 56px; }
        .section-badge {
            display: inline-block; font-size: 11px; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase;
            color: var(--blue); background: var(--bluelt); padding: 4px 14px; border-radius: 100px;
            margin-bottom: 14px;
        }
        .section-title { font-size: clamp(1.9rem, 3.5vw, 2.6rem); font-weight: 800; color: var(--dark2); line-height: 1.2; margin-bottom: 12px; }
        .section-sub { font-size: 16px; color: var(--g500); max-width: 540px; margin: 0 auto; line-height: 1.7; }

        /* ── CATEGORIES ── */
        .cat-section { background: var(--g50); }
        .cat-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 16px;
        }
        .cat-card {
            background: #fff; border: 1.5px solid var(--g200); border-radius: var(--r);
            padding: 24px 20px; text-align: center;
            cursor: pointer; transition: all .22s;
            position: relative; overflow: hidden;
        }
        .cat-card::before {
            content: ''; position: absolute; inset: 0;
            background: var(--bluelt); opacity: 0; transition: opacity .22s;
        }
        .cat-card:hover { border-color: var(--blue3); transform: translateY(-4px); box-shadow: 0 12px 28px rgba(37,99,235,.12); }
        .cat-card:hover::before { opacity: 1; }
        .cat-icon {
            width: 54px; height: 54px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px; margin: 0 auto 14px;
            position: relative; z-index: 1;
            transition: transform .22s;
        }
        .cat-card:hover .cat-icon { transform: scale(1.1); }
        .cat-name { font-weight: 700; font-size: 14px; color: var(--g700); position: relative; z-index: 1; }
        .cat-count { font-size: 12px; color: var(--g400); margin-top: 4px; position: relative; z-index: 1; }

        /* ── HOW IT WORKS ── */
        .how-grid {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 32px;
            position: relative;
        }
        .how-grid::before {
            content: '';
            position: absolute; top: 38px; left: calc(16.66% + 16px); right: calc(16.66% + 16px);
            height: 2px;
            background: repeating-linear-gradient(90deg, var(--g200) 0, var(--g200) 10px, transparent 10px, transparent 20px);
        }
        .how-card {
            background: #fff; border: 1.5px solid var(--g200); border-radius: var(--rl);
            padding: 32px 28px; text-align: center;
            position: relative; z-index: 1;
            transition: all .22s;
        }
        .how-card:hover { border-color: var(--blue3); box-shadow: 0 12px 32px rgba(37,99,235,.1); transform: translateY(-4px); }
        .how-step {
            width: 52px; height: 52px; border-radius: 50%;
            background: var(--blue); color: #fff;
            font-family: 'Syne', sans-serif; font-size: 20px; font-weight: 800;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 6px 18px rgba(37,99,235,.35);
        }
        .how-card h3 { font-size: 18px; font-weight: 700; color: var(--dark2); margin-bottom: 10px; }
        .how-card p { font-size: 14px; color: var(--g500); line-height: 1.7; }
        .how-icon { font-size: 26px; margin-bottom: 14px; }

        /* ── FREELANCERS ── */
        .fl-grid {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 22px;
        }
        .fl-card {
            background: #fff; border: 1.5px solid var(--g200); border-radius: var(--rl);
            padding: 26px; transition: all .22s; cursor: pointer;
        }
        .fl-card:hover { border-color: var(--blue3); box-shadow: 0 12px 32px rgba(37,99,235,.1); transform: translateY(-3px); }
        .fl-top { display: flex; align-items: center; gap: 14px; margin-bottom: 16px; }
        .fl-avatar { width: 52px; height: 52px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 20px; font-weight: 800; color: #fff; flex-shrink: 0; }
        .fl-name { font-family: 'Syne', sans-serif; font-size: 15px; font-weight: 700; color: var(--g800); }
        .fl-title { font-size: 13px; color: var(--g400); margin-top: 2px; }
        .fl-verified { display: inline-flex; align-items: center; gap: 4px; font-size: 11px; font-weight: 700; color: var(--ok); background: var(--oklt); padding: 2px 8px; border-radius: 100px; margin-top: 4px; }
        .fl-rate { font-family: 'Syne', sans-serif; font-size: 1.1rem; font-weight: 800; color: var(--blue); margin-left: auto; }
        .fl-tags { display: flex; flex-wrap: wrap; gap: 6px; margin-bottom: 14px; }
        .fl-tag { font-size: 11px; font-weight: 600; padding: 4px 10px; border-radius: 6px; background: var(--g100); color: var(--g600); }
        .fl-bottom { display: flex; align-items: center; justify-content: space-between; padding-top: 14px; border-top: 1px solid var(--g100); }
        .fl-stars { display: flex; align-items: center; gap: 5px; font-size: 13px; font-weight: 600; color: var(--g700); }
        .fl-stars i { color: var(--amber); }
        .fl-jobs { font-size: 12px; color: var(--g400); }
        .fl-hire { padding: 7px 16px; background: var(--bluelt); color: var(--blue); border: none; border-radius: 8px; font-size: 13px; font-weight: 700; cursor: pointer; transition: all .18s; }
        .fl-hire:hover { background: var(--blue); color: #fff; }

        /* ── TRUST INDICATORS ── */
        .trust-section { background: linear-gradient(160deg, var(--dark2), #0a1628); color: #fff; }
        .trust-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 28px; }
        .trust-card {
            background: rgba(255,255,255,.06); border: 1px solid rgba(255,255,255,.1);
            border-radius: var(--rl); padding: 28px 24px; text-align: center;
            transition: all .22s;
        }
        .trust-card:hover { background: rgba(255,255,255,.1); transform: translateY(-3px); }
        .trust-icon { width: 56px; height: 56px; border-radius: 14px; background: rgba(37,99,235,.25); display: flex; align-items: center; justify-content: center; font-size: 24px; margin: 0 auto 16px; }
        .trust-card h3 { font-size: 17px; font-weight: 700; margin-bottom: 8px; }
        .trust-card p { font-size: 13px; color: rgba(255,255,255,.55); line-height: 1.7; }

        /* ── TESTIMONIALS ── */
        .testi-section { background: var(--g50); }
        .testi-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 22px; }
        .testi-card {
            background: #fff; border: 1.5px solid var(--g200); border-radius: var(--rl);
            padding: 28px; transition: all .22s;
        }
        .testi-card:hover { box-shadow: 0 12px 32px rgba(0,0,0,.08); transform: translateY(-3px); }
        .testi-quote { font-size: 32px; color: var(--blue); line-height: 1; margin-bottom: 14px; }
        .testi-text { font-size: 15px; color: var(--g600); line-height: 1.75; margin-bottom: 20px; font-style: italic; }
        .testi-author { display: flex; align-items: center; gap: 12px; }
        .testi-avatar { width: 44px; height: 44px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 16px; color: #fff; }
        .testi-name { font-weight: 700; font-size: 14px; color: var(--g800); }
        .testi-role { font-size: 12px; color: var(--g400); }
        .testi-stars { margin-left: auto; color: var(--amber); font-size: 13px; }

        /* ── PRICING ── */
        .pricing-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; }
        .price-card {
            background: #fff; border: 2px solid var(--g200); border-radius: var(--rl);
            padding: 36px 28px; text-align: center;
            transition: all .22s; position: relative;
        }
        .price-card:hover { box-shadow: 0 16px 40px rgba(0,0,0,.08); transform: translateY(-4px); }
        .price-card.featured { border-color: var(--blue); box-shadow: 0 8px 32px rgba(37,99,235,.15); }
        .price-pop {
            position: absolute; top: -13px; left: 50%; transform: translateX(-50%);
            background: var(--blue); color: #fff; font-size: 11px; font-weight: 700;
            padding: 4px 14px; border-radius: 100px; letter-spacing: .5px;
            white-space: nowrap;
        }
        .price-name { font-size: 13px; font-weight: 700; color: var(--g500); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; }
        .price-val { font-family: 'Syne', sans-serif; font-size: 2.8rem; font-weight: 800; color: var(--dark2); line-height: 1; }
        .price-val sup { font-size: 1.2rem; vertical-align: top; margin-top: 8px; }
        .price-val sub { font-size: 1rem; font-weight: 400; color: var(--g400); }
        .price-desc { font-size: 13px; color: var(--g400); margin: 10px 0 24px; }
        .price-features { list-style: none; text-align: left; margin-bottom: 28px; display: flex; flex-direction: column; gap: 10px; }
        .price-features li { display: flex; align-items: center; gap: 9px; font-size: 14px; color: var(--g600); }
        .price-features li i { color: var(--ok); font-size: 15px; flex-shrink: 0; }
        .price-btn {
            width: 100%; padding: 12px; border-radius: var(--r); font-size: 14px; font-weight: 700; cursor: pointer; transition: all .18s;
        }
        .price-btn-outline { background: #fff; border: 2px solid var(--g200); color: var(--g700); }
        .price-btn-outline:hover { border-color: var(--blue); color: var(--blue); }
        .price-btn-fill { background: var(--blue); border: none; color: #fff; box-shadow: 0 6px 18px rgba(37,99,235,.3); }
        .price-btn-fill:hover { background: var(--blue2); }

        /* ── JOIN SECTION (original logic preserved) ── */
        .join-section { background: linear-gradient(160deg, #f0f7ff, #e8f5ff); }
        .join-inner { max-width: 700px; margin: 0 auto; text-align: center; }
        .join-inner .section-title { margin-bottom: 10px; }
        .join-inner .section-sub { margin-bottom: 40px; }

        .join-cards {
            display: flex; justify-content: center; gap: 20px; margin-bottom: 32px;
            flex-wrap: wrap;
        }

        .join-card {
            width: 260px; min-height: 160px;
            background: #fff; border: 2px solid var(--g200); border-radius: var(--rl);
            padding: 28px 24px; cursor: pointer;
            transition: all .22s; position: relative; text-align: left;
        }
        .join-card:hover { border-color: var(--blue3); box-shadow: 0 8px 28px rgba(37,99,235,.12); }
        .join-card.selected { border-color: var(--blue); box-shadow: 0 8px 28px rgba(37,99,235,.18); }

        .radio {
            position: absolute; top: 18px; right: 18px;
            width: 20px; height: 20px; border: 2px solid var(--g300);
            border-radius: 50%; transition: all .2s;
        }
        .join-card.selected .radio { border-color: var(--blue); background: var(--blue); }
        .join-card.selected .radio::after {
            content: ''; position: absolute;
            inset: 3px; background: #fff; border-radius: 50%;
        }

        .join-card-icon { font-size: 28px; margin-bottom: 14px; display: block; }
        .join-card h3 { font-size: 16px; font-weight: 700; color: var(--g800); line-height: 1.4; }
        .join-card p { font-size: 13px; color: var(--g400); margin-top: 5px; }

        .join-btn {
            padding: 14px 40px;
            background: var(--blue); color: #fff;
            border: none; border-radius: var(--r);
            font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700;
            cursor: pointer;
            box-shadow: 0 8px 24px rgba(37,99,235,.3);
            transition: all .2s;
        }
        .join-btn:hover:not(:disabled) { background: var(--blue2); transform: translateY(-2px); }
        .join-btn:disabled { background: var(--g200); color: var(--g400); cursor: not-allowed; box-shadow: none; }

        .login-link { margin-top: 18px; font-size: 14px; color: var(--g500); }
        .login-link a { color: var(--blue); font-weight: 600; }
        .login-link a:hover { text-decoration: underline; }

        /* ── FOOTER ── */
        footer {
            background: var(--dark); color: #fff;
            padding: 70px 6% 32px;
        }
        .footer-grid {
            max-width: 1200px; margin: 0 auto;
            display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 48px;
            margin-bottom: 48px;
        }
        .footer-brand .logo-txt { font-size: 1.3rem; }
        .footer-brand p { font-size: 14px; color: rgba(255,255,255,.45); line-height: 1.7; margin-top: 14px; max-width: 260px; }
        .footer-col h5 { font-size: 13px; font-weight: 700; color: rgba(255,255,255,.7); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 16px; }
        .footer-col a { display: block; font-size: 14px; color: rgba(255,255,255,.45); margin-bottom: 10px; transition: color .18s; }
        .footer-col a:hover { color: #fff; }
        .footer-bottom { max-width: 1200px; margin: 0 auto; padding-top: 28px; border-top: 1px solid rgba(255,255,255,.08); display: flex; justify-content: space-between; align-items: center; font-size: 13px; color: rgba(255,255,255,.35); }

        /* ── ANIMATIONS ── */
        @keyframes fadeUp { from { opacity: 0; transform: translateY(24px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes pulse { 0%,100% { opacity: 1; } 50% { opacity: .4; } }

        .reveal { opacity: 0; transform: translateY(28px); transition: opacity .6s ease, transform .6s ease; }
        .reveal.in { opacity: 1; transform: none; }

        /* ── RESPONSIVE ── */
        @media (max-width: 900px) {
            .hero-inner { grid-template-columns: 1fr; }
            .hero-visual { display: none; }
            .how-grid { grid-template-columns: 1fr; }
            .how-grid::before { display: none; }
            .pricing-grid { grid-template-columns: 1fr; }
            .footer-grid { grid-template-columns: 1fr 1fr; }
            .topbar-nav { display: none; }
        }
        @media (max-width: 600px) {
            .section { padding: 60px 5%; }
            .hero { padding: 90px 5% 50px; }
            .join-cards { flex-direction: column; align-items: center; }
            .footer-grid { grid-template-columns: 1fr; }
            .footer-bottom { flex-direction: column; gap: 10px; text-align: center; }
        }
    </style>
</head>
<body>

<!-- ── TOPBAR ── -->
<nav class="topbar" id="topbar">
    <div class="logo">
        <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:34px;height:34px;flex-shrink:0">
            <rect width="34" height="34" rx="9" fill="#2563eb"/>
            <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
            <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
            <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
        </svg>
        <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
    </div>
    <nav class="topbar-nav">
        <a href="#categories">Browse Work</a>
        <a href="#how">How It Works</a>
        <a href="#freelancers">Talent</a>
        <a href="#pricing">Pricing</a>
    </nav>
    <div class="topbar-right">
        <a href="#join" class="btn-solid">Get Started</a>
    </div>
</nav>

<!-- ── HERO ── -->
<section class="hero">
    <div class="hero-inner">
        <div class="hero-left">
            <div class="hero-badge"><span class="dot"></span> #1 Freelancer Marketplace in 2026</div>
            <h1>Hire Skilled Freelancers or Find Your <span class="accent">Dream Projects</span></h1>
            <p class="hero-sub">Connect with top-tier talent or land your next big gig. WorkPort makes it simple, fast, and secure — for both clients and freelancers.</p>
            <div class="hero-btns">
                <a href="#join" class="cta-hire" onclick="document.getElementById('clientCard').click()"><i class="bi bi-briefcase-fill"></i> Hire a Freelancer</a>
                <a href="#join" class="cta-work" onclick="document.getElementById('freelancerCard').click()"><i class="bi bi-lightning-charge-fill"></i> Start Freelancing</a>
            </div>
            <div class="hero-stats">
                <div class="hero-stat"><div class="num">50K+</div><div class="lbl">Active Freelancers</div></div>
                <div class="hero-stat"><div class="num">120K+</div><div class="lbl">Jobs Completed</div></div>
                <div class="hero-stat"><div class="num">4.9★</div><div class="lbl">Average Rating</div></div>
            </div>
        </div>
        <div class="hero-visual">
            <div class="hv-card">
                <div class="hv-card-top">
                    <div class="hv-avatar" style="background:linear-gradient(135deg,#2563eb,#06b6d4)">A</div>
                    <div>
                        <div class="hv-name">Arjun Mehta</div>
                        <div class="hv-role">Full-Stack Developer · Mumbai</div>
                        <div class="hv-stars">
                            <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                            <span style="color:var(--g500);font-size:12px;margin-left:4px;">5.0 (148 jobs)</span>
                        </div>
                    </div>
                    <div style="margin-left:auto;font-family:'Syne',sans-serif;font-size:1.1rem;font-weight:800;color:var(--blue)">$85/hr</div>
                </div>
                <div class="hv-tags">
                    <span class="hv-tag">React</span><span class="hv-tag">Node.js</span><span class="hv-tag">PostgreSQL</span><span class="hv-tag">AWS</span>
                </div>
            </div>
            <div class="hv-small">
                <div class="hv-mini">
                    <div class="hv-mini-icon" style="background:var(--oklt);color:var(--ok)"><i class="bi bi-shield-check"></i></div>
                    <div class="val">99.8%</div>
                    <div class="key">Secure Payments</div>
                </div>
                <div class="hv-mini">
                    <div class="hv-mini-icon" style="background:var(--amberlt);color:var(--amber)"><i class="bi bi-lightning-fill"></i></div>
                    <div class="val">2h</div>
                    <div class="key">Avg. Response Time</div>
                </div>
                <div class="hv-mini">
                    <div class="hv-mini-icon" style="background:var(--bluelt);color:var(--blue)"><i class="bi bi-people-fill"></i></div>
                    <div class="val">50K</div>
                    <div class="key">Verified Freelancers</div>
                </div>
            </div>
            <div class="hv-job">
                <div class="hv-job-title">Senior React Developer Needed</div>
                <div class="hv-job-meta">Posted 2 hours ago · Remote · Long-term</div>
                <div class="hv-job-bottom">
                    <div class="hv-budget">$4,500 – $7,000</div>
                    <button class="hv-apply">Apply Now →</button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ── CATEGORIES ── -->
<section class="section cat-section" id="categories">
    <div class="section-inner">
        <div class="section-header reveal">
            <div class="section-badge">Explore Categories</div>
            <h2 class="section-title">Find Talent for Any Project</h2>
            <p class="section-sub">From code to creative — browse hundreds of skill categories and connect with the right expert instantly.</p>
        </div>
        <div class="cat-grid reveal">
            <div class="cat-card">
                <div class="cat-icon" style="background:#eff6ff"><i class="bi bi-code-slash" style="color:#2563eb"></i></div>
                <div class="cat-name">Web Development</div>
                <div class="cat-count">12,400+ freelancers</div>
            </div>
            <div class="cat-card">
                <div class="cat-icon" style="background:#fdf4ff"><i class="bi bi-palette2" style="color:#a855f7"></i></div>
                <div class="cat-name">UI/UX Design</div>
                <div class="cat-count">8,900+ freelancers</div>
            </div>
            <div class="cat-card">
                <div class="cat-icon" style="background:#f0fdf4"><i class="bi bi-pen" style="color:#10b981"></i></div>
                <div class="cat-name">Content Writing</div>
                <div class="cat-count">9,700+ freelancers</div>
            </div>
            <div class="cat-card">
                <div class="cat-icon" style="background:#fefce8"><i class="bi bi-cpu" style="color:#f59e0b"></i></div>
                <div class="cat-name">AI / Machine Learning</div>
                <div class="cat-count">4,200+ freelancers</div>
            </div>
            <div class="cat-card">
                <div class="cat-icon" style="background:#fff1f2"><i class="bi bi-phone" style="color:#ef4444"></i></div>
                <div class="cat-name">Mobile Apps</div>
                <div class="cat-count">6,100+ freelancers</div>
            </div>
            <div class="cat-card">
                <div class="cat-icon" style="background:#ecfeff"><i class="bi bi-megaphone" style="color:#06b6d4"></i></div>
                <div class="cat-name">Digital Marketing</div>
                <div class="cat-count">7,500+ freelancers</div>
            </div>
            <div class="cat-card">
                <div class="cat-icon" style="background:#fff7ed"><i class="bi bi-camera-video" style="color:#f97316"></i></div>
                <div class="cat-name">Video & Animation</div>
                <div class="cat-count">3,800+ freelancers</div>
            </div>
            <div class="cat-card">
                <div class="cat-icon" style="background:#f0f9ff"><i class="bi bi-bar-chart-line" style="color:#0284c7"></i></div>
                <div class="cat-name">Data & Analytics</div>
                <div class="cat-count">5,300+ freelancers</div>
            </div>
        </div>
    </div>
</section>

<!-- ── HOW IT WORKS ── -->
<section class="section" id="how">
    <div class="section-inner">
        <div class="section-header reveal">
            <div class="section-badge">Simple Process</div>
            <h2 class="section-title">How WorkPort Works</h2>
            <p class="section-sub">Three easy steps to get your project done — or land your next great client.</p>
        </div>
        <div class="how-grid reveal">
            <div class="how-card">
                <div class="how-step">1</div>
                <div class="how-icon">📋</div>
                <h3>Post a Job</h3>
                <p>Describe your project, set your budget and timeline. It takes less than 5 minutes to go live and start receiving proposals.</p>
            </div>
            <div class="how-card">
                <div class="how-step">2</div>
                <div class="how-icon">🤝</div>
                <h3>Hire the Best</h3>
                <p>Browse proposals, check portfolios, and chat with candidates. Our smart matching helps you find the perfect fit fast.</p>
            </div>
            <div class="how-card">
                <div class="how-step">3</div>
                <div class="how-icon">✅</div>
                <h3>Get Work Done</h3>
                <p>Collaborate seamlessly, track milestones, and release payment only when you're 100% satisfied. Simple, safe, and secure.</p>
            </div>
        </div>
    </div>
</section>

<!-- ── FEATURED FREELANCERS ── -->
<section class="section cat-section" id="freelancers">
    <div class="section-inner">
        <div class="section-header reveal">
            <div class="section-badge">Top Talent</div>
            <h2 class="section-title">Featured Freelancers</h2>
            <p class="section-sub">Hand-picked, verified professionals ready to take on your next project.</p>
        </div>
        <div class="fl-grid reveal">
            <div class="fl-card">
                <div class="fl-top">
                    <div class="fl-avatar" style="background:linear-gradient(135deg,#2563eb,#06b6d4)">SM</div>
                    <div>
                        <div class="fl-name">Sofia Martinez</div>
                        <div class="fl-title">Full-Stack Developer</div>
                        <div class="fl-verified"><i class="bi bi-patch-check-fill"></i> Verified Pro</div>
                    </div>
                    <div class="fl-rate">$90/hr</div>
                </div>
                <div class="fl-tags">
                    <span class="fl-tag">React</span><span class="fl-tag">TypeScript</span><span class="fl-tag">Node.js</span><span class="fl-tag">GraphQL</span>
                </div>
                <div class="fl-bottom">
                    <div class="fl-stars"><i class="bi bi-star-fill"></i> 4.98 <span class="fl-jobs">(213 jobs)</span></div>
                    <button class="fl-hire">Hire →</button>
                </div>
            </div>
            <div class="fl-card">
                <div class="fl-top">
                    <div class="fl-avatar" style="background:linear-gradient(135deg,#a855f7,#ec4899)">KP</div>
                    <div>
                        <div class="fl-name">Kai Patel</div>
                        <div class="fl-title">UI/UX Designer</div>
                        <div class="fl-verified"><i class="bi bi-patch-check-fill"></i> Verified Pro</div>
                    </div>
                    <div class="fl-rate">$75/hr</div>
                </div>
                <div class="fl-tags">
                    <span class="fl-tag">Figma</span><span class="fl-tag">Prototyping</span><span class="fl-tag">Motion</span>
                </div>
                <div class="fl-bottom">
                    <div class="fl-stars"><i class="bi bi-star-fill"></i> 5.00 <span class="fl-jobs">(98 jobs)</span></div>
                    <button class="fl-hire">Hire →</button>
                </div>
            </div>
            <div class="fl-card">
                <div class="fl-top">
                    <div class="fl-avatar" style="background:linear-gradient(135deg,#10b981,#0d9488)">JL</div>
                    <div>
                        <div class="fl-name">James Lee</div>
                        <div class="fl-title">AI / ML Engineer</div>
                        <div class="fl-verified"><i class="bi bi-patch-check-fill"></i> Verified Pro</div>
                    </div>
                    <div class="fl-rate">$120/hr</div>
                </div>
                <div class="fl-tags">
                    <span class="fl-tag">Python</span><span class="fl-tag">PyTorch</span><span class="fl-tag">LangChain</span>
                </div>
                <div class="fl-bottom">
                    <div class="fl-stars"><i class="bi bi-star-fill"></i> 4.97 <span class="fl-jobs">(67 jobs)</span></div>
                    <button class="fl-hire">Hire →</button>
                </div>
            </div>
            <div class="fl-card">
                <div class="fl-top">
                    <div class="fl-avatar" style="background:linear-gradient(135deg,#f59e0b,#f97316)">RN</div>
                    <div>
                        <div class="fl-name">Riya Nair</div>
                        <div class="fl-title">Content Strategist</div>
                        <div class="fl-verified"><i class="bi bi-patch-check-fill"></i> Verified Pro</div>
                    </div>
                    <div class="fl-rate">$55/hr</div>
                </div>
                <div class="fl-tags">
                    <span class="fl-tag">SEO Writing</span><span class="fl-tag">Copywriting</span><span class="fl-tag">Brand Voice</span>
                </div>
                <div class="fl-bottom">
                    <div class="fl-stars"><i class="bi bi-star-fill"></i> 4.95 <span class="fl-jobs">(312 jobs)</span></div>
                    <button class="fl-hire">Hire →</button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ── TRUST ── -->
<section class="section trust-section">
    <div class="section-inner">
        <div class="section-header reveal" style="color:#fff">
            <div class="section-badge" style="background:rgba(255,255,255,.12);color:#fff;border:1px solid rgba(255,255,255,.2)">Why WorkPort</div>
            <h2 class="section-title" style="color:#fff">Built on Trust & Security</h2>
            <p class="section-sub" style="color:rgba(255,255,255,.55)">Every transaction, every interaction, protected from start to finish.</p>
        </div>
        <div class="trust-grid reveal">
            <div class="trust-card">
                <div class="trust-icon"><i class="bi bi-shield-lock-fill"></i></div>
                <h3>Secure Payments</h3>
                <p>Funds held in escrow until you approve the work. No upfront risk, no hidden fees.</p>
            </div>
            <div class="trust-card">
                <div class="trust-icon"><i class="bi bi-person-check-fill"></i></div>
                <h3>Verified Freelancers</h3>
                <p>Every freelancer is ID-verified, skill-tested, and reviewed by our trust team before listing.</p>
            </div>
            <div class="trust-card">
                <div class="trust-icon"><i class="bi bi-headset"></i></div>
                <h3>24/7 Support</h3>
                <p>Dedicated dispute resolution and live support around the clock for every user.</p>
            </div>
            <div class="trust-card">
                <div class="trust-icon"><i class="bi bi-award-fill"></i></div>
                <h3>Money-Back Guarantee</h3>
                <p>Not satisfied? We'll make it right — full refund protection on every project.</p>
            </div>
        </div>
    </div>
</section>

<!-- ── TESTIMONIALS ── -->
<section class="section testi-section">
    <div class="section-inner">
        <div class="section-header reveal">
            <div class="section-badge">What People Say</div>
            <h2 class="section-title">Loved by Clients & Freelancers</h2>
            <p class="section-sub">Real stories from the people who power WorkPort every day.</p>
        </div>
        <div class="testi-grid reveal">
            <div class="testi-card">
                <div class="testi-quote">"</div>
                <p class="testi-text">WorkPort completely changed how we hire. We found an amazing React dev within 24 hours and the entire process was seamless. The escrow system gave us total peace of mind.</p>
                <div class="testi-author">
                    <div class="testi-avatar" style="background:linear-gradient(135deg,#2563eb,#06b6d4)">PK</div>
                    <div>
                        <div class="testi-name">Priya Krishnan</div>
                        <div class="testi-role">CTO, NovaTech Startups</div>
                    </div>
                    <div class="testi-stars"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i></div>
                </div>
            </div>
            <div class="testi-card">
                <div class="testi-quote">"</div>
                <p class="testi-text">As a freelancer, WorkPort is a game-changer. The quality of clients here is unmatched. I doubled my income within 3 months and the payment protection is rock-solid.</p>
                <div class="testi-author">
                    <div class="testi-avatar" style="background:linear-gradient(135deg,#10b981,#0d9488)">DM</div>
                    <div>
                        <div class="testi-name">David Mwangi</div>
                        <div class="testi-role">Freelance Developer</div>
                    </div>
                    <div class="testi-stars"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i></div>
                </div>
            </div>
            <div class="testi-card">
                <div class="testi-quote">"</div>
                <p class="testi-text">I was skeptical at first, but the talent pool here is genuinely world-class. Our designer delivered work that exceeded every expectation — on time and under budget.</p>
                <div class="testi-author">
                    <div class="testi-avatar" style="background:linear-gradient(135deg,#f59e0b,#f97316)">LH</div>
                    <div>
                        <div class="testi-name">Laura Huang</div>
                        <div class="testi-role">Founder, PixelForge Agency</div>
                    </div>
                    <div class="testi-stars"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i></div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ── PRICING ── -->
<section class="section" id="pricing">
    <div class="section-inner">
        <div class="section-header reveal">
            <div class="section-badge">Transparent Pricing</div>
            <h2 class="section-title">Simple, Fair Commission</h2>
            <p class="section-sub">No surprises. No hidden fees. WorkPort takes a small commission so you always keep the lion's share.</p>
        </div>
        <div class="pricing-grid reveal">
            <div class="price-card">
                <div class="price-name">Starter</div>
                <div class="price-val"><sup>$</sup>0<sub>/mo</sub></div>
                <div class="price-desc">Perfect for getting started</div>
                <ul class="price-features">
                    <li><i class="bi bi-check-circle-fill"></i> Post up to 3 jobs/month</li>
                    <li><i class="bi bi-check-circle-fill"></i> 10% platform commission</li>
                    <li><i class="bi bi-check-circle-fill"></i> Basic talent search</li>
                    <li><i class="bi bi-check-circle-fill"></i> Standard support</li>
                </ul>
                <button class="price-btn price-btn-outline">Get Started Free</button>
            </div>
            <div class="price-card featured">
                <div class="price-pop">⭐ Most Popular</div>
                <div class="price-name">Professional</div>
                <div class="price-val"><sup>$</sup>49<sub>/mo</sub></div>
                <div class="price-desc">Best for growing teams</div>
                <ul class="price-features">
                    <li><i class="bi bi-check-circle-fill"></i> Unlimited job posts</li>
                    <li><i class="bi bi-check-circle-fill"></i> Reduced 5% commission</li>
                    <li><i class="bi bi-check-circle-fill"></i> Advanced talent filters</li>
                    <li><i class="bi bi-check-circle-fill"></i> Priority support (24h)</li>
                    <li><i class="bi bi-check-circle-fill"></i> Featured job badge</li>
                </ul>
                <button class="price-btn price-btn-fill">Start Pro Trial</button>
            </div>
            <div class="price-card">
                <div class="price-name">Enterprise</div>
                <div class="price-val" style="font-size:2rem">Custom</div>
                <div class="price-desc">For large-scale hiring needs</div>
                <ul class="price-features">
                    <li><i class="bi bi-check-circle-fill"></i> Volume discounts</li>
                    <li><i class="bi bi-check-circle-fill"></i> Custom commission rate</li>
                    <li><i class="bi bi-check-circle-fill"></i> Dedicated account manager</li>
                    <li><i class="bi bi-check-circle-fill"></i> SLA-backed support</li>
                    <li><i class="bi bi-check-circle-fill"></i> API & SSO access</li>
                </ul>
                <button class="price-btn price-btn-outline">Contact Sales</button>
            </div>
        </div>
    </div>
</section>

<!-- ── JOIN (ORIGINAL LOGIC PRESERVED) ── -->
<section class="section join-section" id="join">
    <div class="section-inner">
        <div class="join-inner">
            <div class="section-badge">Get Started</div>
            <h2 class="section-title">Join as a Client or Freelancer</h2>
            <p class="section-sub">Tell us who you are and we'll create the perfect experience for you.</p>

            <div class="join-cards">
                <div class="join-card" onclick="selectRole('client')" id="clientCard">
                    <div class="radio"></div>
                    <span class="join-card-icon">🏢</span>
                    <h3>I'm a client, hiring for a project</h3>
                    <p>Post jobs and hire skilled professionals.</p>
                </div>
                <div class="join-card" onclick="selectRole('freelancer')" id="freelancerCard">
                    <div class="radio"></div>
                    <span class="join-card-icon">💼</span>
                    <h3>I'm a freelancer, looking for work</h3>
                    <p>Find projects that match your expertise.</p>
                </div>
            </div>

            <button class="join-btn" id="joinBtn" onclick="goSignup()" disabled>Join WorkPort</button>

            <div class="login-link">Already have an account? <a href="login.jsp">Log In</a></div>
        </div>
    </div>
</section>

<!-- ── FOOTER ── -->
<footer>
    <div class="footer-grid">
        <div class="footer-brand">
            <div class="logo">
                <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:30px;height:30px;flex-shrink:0">
                    <rect width="34" height="34" rx="9" fill="#2563eb"/>
                    <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
                    <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
                    <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
                </svg>
                <span class="logo-txt"><span class="w" style="color:#fff">Work</span><span class="p">Port</span></span>
            </div>
            <p>Connecting world-class talent with great companies. Build your future with WorkPort.</p>
        </div>
        <div class="footer-col">
            <h5>For Clients</h5>
            <a href="#">Post a Job</a>
            <a href="#">Find Freelancers</a>
            <a href="#">Enterprise</a>
            <a href="#">Success Stories</a>
        </div>
        <div class="footer-col">
            <h5>For Freelancers</h5>
            <a href="#">Find Work</a>
            <a href="#">Create Profile</a>
            <a href="#">Community</a>
            <a href="#">Learning Hub</a>
        </div>
        <div class="footer-col">
            <h5>Company</h5>
            <a href="#">About Us</a>
            <a href="#">Blog</a>
            <a href="#">Careers</a>
            <a href="#">Privacy Policy</a>
        </div>
    </div>
    <div class="footer-bottom">
        <span>&copy; 2026 WorkPort Marketplace Inc. All rights reserved.</span>
        <span>🔒 Payments secured by Stripe</span>
    </div>
</footer>

<script>
    /* ── ORIGINAL LOGIC — UNTOUCHED ── */
    let selectedRole = "";

    function selectRole(role) {
        selectedRole = role;
        document.getElementById("clientCard").classList.remove("selected");
        document.getElementById("freelancerCard").classList.remove("selected");
        document.getElementById(role + "Card").classList.add("selected");
        document.getElementById("joinBtn").disabled = false;
        document.getElementById("joinBtn").innerText =
            role === "client" ? "Join as a Client →" : "Join as a Freelancer →";
    }

    function goSignup() {
        if (selectedRole !== "") {
            window.location.href = "signup.jsp?type=" + selectedRole;
        }
    }

    /* ── TOPBAR SCROLL ── */
    window.addEventListener('scroll', () => {
        document.getElementById('topbar').classList.toggle('sc', window.scrollY > 10);
    });

    /* ── SCROLL REVEAL ── */
    const reveals = document.querySelectorAll('.reveal');
    const obs = new IntersectionObserver((entries) => {
        entries.forEach((e, i) => {
            if (e.isIntersecting) {
                setTimeout(() => e.target.classList.add('in'), i * 80);
                obs.unobserve(e.target);
            }
        });
    }, { threshold: 0.1 });
    reveals.forEach(el => obs.observe(el));
</script>

</body>
</html>
