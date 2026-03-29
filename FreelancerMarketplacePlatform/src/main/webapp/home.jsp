<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.model.ClientProfile,java.util.List,com.model.Job,com.model.JobSkill" %>
<%@ page import="com.freelancer.services.EscrowService" %>
<%
ClientProfile profile = (ClientProfile) request.getAttribute("profile");
if (profile == null) { response.sendRedirect("login.jsp"); return; }

int completed = 40;
if (profile.getPhone() != null && !profile.getPhone().trim().isEmpty()) completed += 20;
if (profile.getCompanyname() != null && !profile.getCompanyname().trim().isEmpty()) completed += 20;
if (profile.getCompanybio() != null && !profile.getCompanybio().trim().isEmpty()) completed += 20;
boolean profileComplete = (completed == 100);

List<Job> activeJobs  = (List<Job>) request.getAttribute("activeJobs");
List<Job> workingJobs = (List<Job>) request.getAttribute("workingJobs");
int activeCount  = (activeJobs  != null) ? activeJobs.size()  : 0;
int ongoingCount = (workingJobs != null) ? workingJobs.size() : 0;
%><!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Client Dashboard | WorkPort</title>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
:root{
  --blue:#2563eb;--blue2:#1d4ed8;--blue3:#3b82f6;
  --bluelt:#eff6ff;--blue1:#dbeafe;
  --cyan:#06b6d4;--violet:#8b5cf6;
  --dark:#0c1a3a;--hero:#1e2d45;
  --g50:#f9fafb;--g100:#f3f4f6;--g200:#e5e7eb;
  --g400:#9ca3af;--g600:#4b5563;--g800:#1f2937;
  --ok:#10b981;--err:#ef4444;--warn:#f59e0b;
  --navh:64px;
  --r:14px;--rs:9px;--rl:18px;
  --s1:0 2px 8px rgba(0,0,0,.07);
  --s2:0 10px 32px rgba(37,99,235,.13),0 2px 8px rgba(0,0,0,.06);
  --s3:0 20px 48px rgba(37,99,235,.17),0 4px 16px rgba(0,0,0,.08);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
html{scroll-behavior:smooth;}
body{font-family:'DM Sans',sans-serif;background:#f1f5f9;color:var(--g800);overflow-x:hidden;}
h1,h2,h3,h4{font-family:'Plus Jakarta Sans',sans-serif;}
a{text-decoration:none;color:inherit;}
button{font-family:'DM Sans',sans-serif;cursor:pointer;}

/* REVEAL */
.rv{opacity:0;transform:translateY(20px);transition:opacity .55s cubic-bezier(.22,1,.36,1),transform .55s cubic-bezier(.22,1,.36,1);}
.rv.on{opacity:1;transform:none;}
.d1{transition-delay:.07s;}.d2{transition-delay:.14s;}.d3{transition-delay:.21s;}.d4{transition-delay:.28s;}

/* ══ NAVBAR ══ */
/* ══ NAVBAR ══ */
.nav{
  position:fixed;top:0;left:0;right:0;height:var(--navh);z-index:900;
  display:flex;align-items:center;padding:0 2.5%;gap:8px;
  background:rgba(255,255,255,.93);
  backdrop-filter:blur(16px);-webkit-backdrop-filter:blur(16px);
  border-bottom:1px solid var(--g200);transition:box-shadow .3s;
}
.nav.sc{box-shadow:0 2px 12px rgba(0,0,0,.08);}
.logo{display:flex;align-items:center;gap:8px;flex-shrink:0;}
.logo-svg{width:34px;height:34px;}
.logo-txt{font-family:'Plus Jakarta Sans',sans-serif;font-size:1.4rem;font-weight:800;letter-spacing:-.3px;}
.logo-txt .w{color:var(--g800);}.logo-txt .p{color:var(--blue);}

/* ↓ increased gap between nav items */
.nlinks{display:flex;align-items:center;gap:6px;margin-left:24px;}

.ni{position:relative;}

/* ↓ larger font, more padding, bolder */
.nl{display:flex;align-items:center;gap:5px;padding:8px 14px;font-size:15px;font-weight:700;color:var(--g600);border-radius:var(--rs);transition:all .18s;cursor:pointer;white-space:nowrap;}

.nl:hover{color:var(--blue);background:var(--bluelt);}
.ca{font-size:10px;transition:transform .18s;}
.ni:hover .ca{transform:rotate(180deg);}
.dd{position:absolute;top:calc(100% + 8px);left:0;background:#fff;border:1px solid var(--g200);border-radius:var(--r);box-shadow:var(--s2);padding:6px;min-width:195px;opacity:0;visibility:hidden;transform:translateY(-5px);transition:all .2s cubic-bezier(.22,1,.36,1);z-index:200;}
.ni:hover .dd{opacity:1;visibility:visible;transform:none;}
.dd a{display:flex;align-items:center;gap:8px;padding:9px 12px;border-radius:var(--rs);font-size:13px;font-weight:600;color:var(--g600);transition:all .16s;}
.dd a i{font-size:14px;color:var(--blue3);}
.dd a:hover{background:var(--bluelt);color:var(--blue);padding-left:16px;}

/* ↓ more breathing room on the right side */
.nr{display:flex;align-items:center;gap:10px;margin-left:auto;}

/* ↓ slightly larger icon buttons */
.nibtn{width:38px;height:38px;border-radius:9px;border:1.5px solid var(--g200);background:#fff;display:flex;align-items:center;justify-content:center;color:var(--g600);font-size:16px;position:relative;transition:all .18s;}

.nibtn:hover{border-color:var(--blue3);color:var(--blue);background:var(--bluelt);transform:translateY(-1px);}
.nbadge{position:absolute;top:5px;right:5px;width:7px;height:7px;background:var(--err);border-radius:50%;border:1.5px solid #fff;}
.nprof{display:flex;align-items:center;gap:8px;padding:4px 8px;border-radius:8px;transition:background .18s;}
.nprof:hover{background:var(--g100);}
.navtr{width:32px;height:32px;border-radius:50%;flex-shrink:0;background:linear-gradient(135deg,var(--blue),var(--cyan));color:#fff;font-weight:800;font-size:13px;display:flex;align-items:center;justify-content:center;}
.nname{font-size:13px;font-weight:700;color:var(--g800);}
.nrole{font-size:10px;font-weight:700;color:var(--blue);background:var(--bluelt);padding:1px 6px;border-radius:5px;text-transform:uppercase;letter-spacing:.3px;display:block;}
.nbtn{display:flex;align-items:center;gap:5px;padding:7px 14px;background:transparent;border:1.5px solid var(--g200);border-radius:var(--rs);font-size:13px;font-weight:700;color:var(--g600);transition:all .18s;}
.nbtn:hover{border-color:var(--err);color:var(--err);background:#fff5f5;}
/* ══ HERO — Fiverr-style with diagonal split & professional person image ══ */
.hero{
  margin-top:var(--navh);
  position:relative;
  height:460px;
  overflow:hidden;
  background:#1e2d45;
}

/* Diagonal background split — white/pink on right like Fiverr */
.hero-bg-shape{
  position:absolute;
  top:0;right:0;
  width:52%;
  height:100%;
  background:linear-gradient(135deg,#f0f4ff 0%,#e8f0fe 40%,#dce8fd 100%);
  clip-path:polygon(12% 0,100% 0,100% 100%,0% 100%);
  z-index:0;
}

/* Left dark content area */
.hl{
  position:absolute;
  top:0;left:0;
  width:52%;
  height:100%;
  z-index:2;
  padding:50px 3% 50px 3%;
  display:flex;flex-direction:column;justify-content:center;
}
.hl::before{content:'';position:absolute;inset:0;pointer-events:none;z-index:0;background-image:radial-gradient(rgba(255,255,255,.04) 1px,transparent 1px);background-size:26px 26px;}
.hl>*{position:relative;z-index:1;}

/* Right: professional person image — cutout style like Fiverr */
.hr{
  position:absolute;
  right:0;top:0;
  width:50%;
  height:100%;
  z-index:1;
  overflow:hidden;
}
.hr img{
  position:absolute;
  bottom:0;
  right:4%;
  height:105%;
  width:auto;
  object-fit:contain;
  object-position:bottom center;
  filter:drop-shadow(-8px 0 24px rgba(30,45,69,.18));
}
/* Freelancer label badge — like Fiverr's "Melissa, Social Media Marketer" */
.freelancer-badge{
  position:absolute;
  bottom:22px;
  right:calc(4% + 10px);
  background:rgba(255,255,255,.95);
  backdrop-filter:blur(8px);
  border-radius:10px;
  padding:8px 14px;
  display:flex;align-items:center;gap:8px;
  box-shadow:0 4px 20px rgba(0,0,0,.12);
  z-index:3;
}
.fb-stars{color:#f59e0b;font-size:12px;letter-spacing:1px;}
.fb-name{font-size:12px;font-weight:700;color:var(--g800);}
.fb-role{font-size:11px;color:var(--g400);}

.hwelcome{display:flex;align-items:center;gap:7px;font-size:13px;font-weight:600;color:rgba(255,255,255,.6);margin-bottom:10px;}
.wd{width:6px;height:6px;background:var(--cyan);border-radius:50%;animation:pu 2s infinite;flex-shrink:0;}
.hwelcome strong{color:#fff;}
@keyframes pu{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.4;transform:scale(1.5)}}
.hl h1{font-size:clamp(1.9rem,3.2vw,2.8rem);font-weight:800;color:#fff;line-height:1.12;letter-spacing:-.7px;margin-bottom:12px;}
.hl h1 .ac{background:linear-gradient(90deg,#60a5fa,#06b6d4);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}
.hsub{font-size:14px;color:rgba(255,255,255,.55);line-height:1.72;max-width:420px;margin-bottom:22px;}
.hsr{display:flex;align-items:center;gap:10px;flex-wrap:wrap;margin-bottom:14px;}
.hsbox{position:relative;flex:1;min-width:200px;max-width:320px;}
.hsbox i{position:absolute;left:13px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,.4);font-size:15px;pointer-events:none;}
.hsbox input{width:100%;padding:11px 12px 11px 38px;background:rgba(255,255,255,.10);border:1.5px solid rgba(255,255,255,.18);border-radius:10px;font-size:14px;font-family:'DM Sans',sans-serif;color:#fff;outline:none;backdrop-filter:blur(6px);transition:all .2s;}
.hsbox input::placeholder{color:rgba(255,255,255,.38);}
.hsbox input:focus{background:rgba(255,255,255,.16);border-color:rgba(255,255,255,.34);box-shadow:0 0 0 3px rgba(96,165,250,.18);}
.hor{font-size:13px;font-weight:600;color:rgba(255,255,255,.38);}
.btnp{display:inline-flex;align-items:center;gap:7px;padding:11px 18px;background:var(--blue);color:#fff;border-radius:10px;font-size:13.5px;font-weight:800;border:none;font-family:'Plus Jakarta Sans',sans-serif;box-shadow:0 4px 14px rgba(37,99,235,.45);transition:all .22s;white-space:nowrap;}
.btnp:hover{background:var(--blue2);transform:translateY(-2px);box-shadow:0 8px 22px rgba(37,99,235,.55);color:#fff;}
.btnp.dis{background:#475569;box-shadow:none;}.btnp.dis:hover{transform:none;box-shadow:none;}
.btng{display:inline-flex;align-items:center;gap:7px;padding:10px 17px;background:rgba(255,255,255,.1);color:#fff;border-radius:10px;font-size:13.5px;font-weight:700;border:1.5px solid rgba(255,255,255,.2);font-family:'DM Sans',sans-serif;backdrop-filter:blur(6px);transition:all .22s;}
.btng:hover{background:rgba(255,255,255,.2);transform:translateY(-2px);color:#fff;}
.chips{display:flex;flex-wrap:wrap;gap:6px;margin-bottom:18px;}
.chip{padding:4px 10px;background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.14);border-radius:20px;font-size:12px;font-weight:600;color:rgba(255,255,255,.6);cursor:pointer;transition:all .18s;}
.chip:hover{background:rgba(255,255,255,.18);color:#fff;border-color:rgba(255,255,255,.3);}

/* ══ POPULAR SERVICES SECTION (replaces slider) ══ */
.services-sec{
  background:#f1f5f9;
  padding:36px 2.5%;
  border-bottom:1.5px solid var(--g200);
}
.services-sec-title{
  font-family:'Plus Jakarta Sans',sans-serif;
  font-size:1.15rem;
  font-weight:700;
  color:var(--g800);
  margin-bottom:20px;
  padding-left:80px;
}
.services-grid{
  display:flex;
  gap:16px;
  flex-wrap:wrap;
  justify-content:center;
  padding-bottom:6px;
}
.services-grid::-webkit-scrollbar{display:none;}
.svc-card{
  flex:0 0 170px;
  border-radius:14px;
  overflow:hidden;
  cursor:pointer;
  position:relative;
  height:148px;
  transition:transform .25s cubic-bezier(.22,1,.36,1),box-shadow .25s;
  border:1.5px solid var(--g200);
}
.svc-card:hover{transform:translateY(-5px);box-shadow:0 14px 36px rgba(37,99,235,.16);}
.svc-card-bg{
  width:100%;height:100%;
  object-fit:cover;
  display:block;
  transition:transform .4s cubic-bezier(.22,1,.36,1);
}
.svc-card:hover .svc-card-bg{transform:scale(1.07);}
.svc-card-overlay{
  position:absolute;
  inset:0;
  background:linear-gradient(180deg,rgba(0,0,0,.08) 0%,rgba(0,0,0,.65) 100%);
  display:flex;flex-direction:column;justify-content:flex-end;
  padding:14px 13px;
}
.svc-card-sub{font-size:10px;font-weight:700;color:rgba(255,255,255,.7);text-transform:uppercase;letter-spacing:.8px;margin-bottom:3px;}
.svc-card-name{font-family:'Plus Jakarta Sans',sans-serif;font-size:14px;font-weight:800;color:#fff;line-height:1.2;}

/* ══ PAGE CONTENT ══ */
.pw{padding:24px 2.5% 52px;width:100%;}

/* incomplete banner */
.ib{display:flex;align-items:center;gap:13px;padding:15px 18px;background:linear-gradient(135deg,#fffbeb,#fef3c7);border:1px solid #fde68a;border-radius:var(--r);margin-bottom:22px;transition:box-shadow .25s;}
.ib:hover{box-shadow:0 4px 16px rgba(245,158,11,.16);}
.ib i{font-size:18px;color:var(--warn);flex-shrink:0;}
.ib strong{font-size:13.5px;color:#92400e;display:block;}
.ib p{font-size:12.5px;color:#b45309;margin-top:1px;}
.ibr{display:flex;flex-direction:column;align-items:flex-end;gap:4px;margin-left:auto;flex-shrink:0;}
.ibr span{font-size:11.5px;font-weight:700;color:#92400e;}
.pb{width:96px;height:5px;background:#fde68a;border-radius:99px;overflow:hidden;}
.pf{height:100%;background:var(--warn);border-radius:99px;}
.bcomp{display:inline-flex;align-items:center;gap:4px;padding:7px 12px;background:var(--bluelt);color:var(--blue);border:1.5px solid var(--blue1);border-radius:var(--rs);font-size:12.5px;font-weight:700;margin-left:9px;flex-shrink:0;transition:all .2s;}
.bcomp:hover{background:var(--blue);color:#fff;border-color:var(--blue);}

/* section header */
.sh{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;}
.sht{font-size:1.05rem;font-weight:700;color:var(--g800);display:flex;align-items:center;gap:8px;}
.shi{width:30px;height:30px;border-radius:8px;background:var(--bluelt);display:flex;align-items:center;justify-content:center;color:var(--blue);font-size:14px;flex-shrink:0;}
.shb{font-size:11px;font-weight:700;background:var(--bluelt);color:var(--blue);padding:3px 10px;border-radius:20px;}
.shb.g{background:#dcfce7;color:#15803d;}

/* ══ HORIZONTAL CARD ROW ══ */
.card-scroll-wrap{position:relative;padding:0 10px;}
.card-row{display:flex;gap:18px;overflow-x:auto;padding-bottom:10px;padding-top:4px;scroll-behavior:smooth;-webkit-overflow-scrolling:touch;}
.card-row::-webkit-scrollbar{height:0;}
.card-row{scrollbar-width:none;}
.row-arr{position:absolute;top:50%;transform:translateY(-60%);width:36px;height:36px;background:#fff;border:1.5px solid var(--g200);border-radius:50%;display:flex;align-items:center;justify-content:center;cursor:pointer;z-index:10;font-size:14px;color:var(--g600);box-shadow:var(--s1);transition:all .22s;}
.row-arr:hover{border-color:var(--blue);color:var(--blue);box-shadow:var(--s2);transform:translateY(-60%) scale(1.08);}
.row-arr-l{left:-6px;}.row-arr-r{right:-6px;}

/* ══ JOB CARD ══ */
.jcard{
  background:#fff;border:1.5px solid var(--g200);border-radius:16px;padding:24px;flex:0 0 360px;min-width:0;
  display:flex;flex-direction:column;gap:14px;
  transition:transform .25s cubic-bezier(.22,1,.36,1),box-shadow .25s cubic-bezier(.22,1,.36,1),border-color .25s;
  position:relative;will-change:transform;
}
.jcard:hover{transform:translateY(-6px);box-shadow:0 12px 36px rgba(37,99,235,.14),0 2px 8px rgba(0,0,0,.06);border-color:#93c5fd;}
.jcard.og{border-top:3px solid var(--ok);}
.jcard-top{display:flex;align-items:flex-start;gap:12px;}
.jcard-ico{width:42px;height:42px;border-radius:50%;background:var(--g100);border:2px solid var(--g200);display:flex;align-items:center;justify-content:center;color:var(--g400);font-size:18px;flex-shrink:0;transition:all .25s;}
.jcard:hover .jcard-ico{background:var(--bluelt);border-color:var(--blue1);color:var(--blue);}
.jcard.og .jcard-ico{background:#f0fdf4;border-color:#bbf7d0;color:#15803d;}
.jcard-title-wrap{flex:1;min-width:0;}
.jcard-name{font-family:'Plus Jakarta Sans',sans-serif;font-size:1rem;font-weight:700;color:var(--g800);line-height:1.3;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;transition:color .2s;}
.jcard:hover .jcard-name{color:var(--blue);}
.jcard-status-badge{display:inline-flex;align-items:center;gap:4px;font-size:11px;font-weight:700;padding:3px 9px;border-radius:20px;margin-top:5px;}
.badge-blue{background:var(--bluelt);color:var(--blue);}
.badge-green{background:#dcfce7;color:#15803d;}
.badge-blue::before,.badge-green::before{content:'';width:5px;height:5px;border-radius:50%;flex-shrink:0;}
.badge-blue::before{background:var(--blue3);}
.badge-green::before{background:var(--ok);animation:pu 2s infinite;}
.jcard-menu{width:30px;height:30px;border-radius:8px;background:transparent;border:none;display:flex;align-items:center;justify-content:center;color:var(--g400);font-size:20px;cursor:pointer;transition:all .18s;flex-shrink:0;letter-spacing:-.5px;}
.jcard-menu:hover{background:var(--g100);color:var(--g600);}
.jcard-meta{display:flex;flex-wrap:wrap;gap:10px;font-size:13px;color:var(--g600);}
.jcard-meta span{display:flex;align-items:center;gap:5px;background:var(--g50);padding:4px 10px;border-radius:20px;border:1px solid var(--g200);}
.jcard-meta i{font-size:13px;color:var(--blue3);}
.jcard-desc{font-size:13px;color:var(--g600);line-height:1.6;display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical;overflow:hidden;flex:1;}
.jcard-actions{display:flex;gap:8px;margin-top:auto;padding-top:14px;border-top:1px solid var(--g100);}
.bv,.bd,.bc{display:inline-flex;align-items:center;justify-content:center;gap:5px;padding:9px 14px;border-radius:var(--rs);font-size:13px;font-weight:700;font-family:'DM Sans',sans-serif;border:1.5px solid;transition:transform .2s,box-shadow .2s,background .2s,color .2s,border-color .2s;flex:1;white-space:nowrap;will-change:transform;}
.bv{background:var(--bluelt);color:var(--blue);border-color:var(--blue1);}
.bv:hover{background:var(--blue);color:#fff;border-color:var(--blue);transform:translateY(-2px);box-shadow:0 6px 14px rgba(37,99,235,.3);}
.bd{background:#fff;color:var(--err);border-color:#fecaca;}
.bd:hover{background:var(--err);color:#fff;border-color:var(--err);transform:translateY(-2px);box-shadow:0 6px 14px rgba(239,68,68,.25);}
.bc{background:#f0fdf4;color:#15803d;border-color:#bbf7d0;}
.bc:hover{background:var(--ok);color:#fff;border-color:var(--ok);transform:translateY(-2px);box-shadow:0 6px 14px rgba(16,185,129,.25);}

/* Post a job card */
.post-card{background:#fff;border:2px dashed var(--g200);border-radius:16px;padding:24px;flex:0 0 240px;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:12px;cursor:pointer;transition:all .25s cubic-bezier(.22,1,.36,1);text-align:center;}
.post-card:hover{border-color:var(--blue);background:var(--bluelt);transform:translateY(-6px);box-shadow:0 12px 32px rgba(37,99,235,.12);}
.post-card i{font-size:28px;color:var(--blue);transition:transform .25s;}
.post-card:hover i{transform:scale(1.15) rotate(8deg);}
.post-card span{font-size:14px;font-weight:700;color:var(--blue);}

/* empty */
.empty{text-align:center;padding:44px 20px;background:#fff;border:2px dashed var(--g200);border-radius:var(--r);transition:all .25s;width:100%;}
.empty:hover{border-color:#93c5fd;background:var(--bluelt);}
.ei{width:50px;height:50px;background:var(--g200);border-radius:12px;display:flex;align-items:center;justify-content:center;margin:0 auto 12px;font-size:22px;color:var(--g400);transition:all .25s;}
.empty:hover .ei{background:var(--blue1);color:var(--blue3);}
.empty h4{font-size:14px;font-weight:700;color:var(--g600);margin-bottom:4px;}
.empty p{font-size:12.5px;color:var(--g400);}

.div{border:0;border-top:1.5px solid var(--g100);margin:26px 0;}

/* resource cards */
.rg{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:14px;}
.rc{background:#fff;border:1.5px solid var(--g200);border-radius:16px;padding:24px;cursor:pointer;position:relative;overflow:hidden;transition:transform .25s cubic-bezier(.22,1,.36,1),box-shadow .25s,border-color .25s;will-change:transform;}
.rc::after{content:'';position:absolute;bottom:0;left:0;right:0;height:3px;background:linear-gradient(90deg,var(--blue3),var(--cyan));transform:scaleX(0);transform-origin:left;transition:transform .3s cubic-bezier(.22,1,.36,1);}
.rc:hover{border-color:#93c5fd;box-shadow:0 12px 36px rgba(37,99,235,.13),0 2px 8px rgba(0,0,0,.05);transform:translateY(-6px);}
.rc:hover::after{transform:scaleX(1);}
.ri{width:48px;height:48px;border-radius:13px;display:flex;align-items:center;justify-content:center;font-size:22px;margin-bottom:14px;transition:transform .25s;}
.rc:hover .ri{transform:scale(1.12) rotate(-5deg);}
.rib{background:var(--bluelt);color:var(--blue);}
.ric{background:#ecfeff;color:var(--cyan);}
.riv{background:#f5f3ff;color:var(--violet);}
.ra{position:absolute;top:18px;right:18px;font-size:15px;color:var(--g400);transition:all .22s;}
.rc:hover .ra{color:var(--blue3);transform:translate(3px,-3px);}
.rc h3{font-size:15px;font-weight:700;margin-bottom:7px;color:var(--g800);transition:color .2s;}
.rc:hover h3{color:var(--blue);}
.rc p{font-size:13px;color:var(--g400);line-height:1.6;}

/* modal */
.mo{display:none;position:fixed;inset:0;background:rgba(15,23,42,.52);z-index:3000;align-items:center;justify-content:center;backdrop-filter:blur(5px);}
.mo.open{display:flex;}
.mb{background:#fff;width:92%;max-width:530px;border-radius:var(--rl);padding:28px;position:relative;box-shadow:var(--s3);animation:mp .28s cubic-bezier(.22,1,.36,1);}
@keyframes mp{from{transform:scale(.92) translateY(12px);opacity:0}to{transform:scale(1) translateY(0);opacity:1}}
.mc{position:absolute;top:12px;right:12px;width:27px;height:27px;background:var(--g100);border:none;border-radius:7px;cursor:pointer;display:flex;align-items:center;justify-content:center;color:var(--g600);font-size:14px;transition:all .18s;}
.mc:hover{background:var(--g200);transform:rotate(90deg);}
.mtp{padding-bottom:12px;border-bottom:1.5px solid var(--g100);margin-bottom:14px;}
.mtt{font-size:1.05rem;font-weight:800;color:var(--g800);margin-bottom:3px;}
.mts{font-size:12px;color:var(--g400);}
.dr{display:flex;gap:10px;padding:9px 0;border-bottom:1px solid var(--g100);align-items:flex-start;}
.dr:last-child{border-bottom:0;padding-bottom:0;}
.di{width:27px;height:27px;background:var(--bluelt);border-radius:7px;display:flex;align-items:center;justify-content:center;color:var(--blue3);font-size:13px;flex-shrink:0;}
.dl{font-size:10px;font-weight:700;color:var(--g400);text-transform:uppercase;letter-spacing:.5px;}
.dv{font-size:13px;font-weight:600;color:var(--g800);margin-top:2px;}
.dd2{font-size:13px;color:var(--g600);line-height:1.72;margin-top:7px;padding-left:37px;}

/* footer */
.ft{background:var(--dark);padding:44px 2.5% 22px;}
.fg{display:grid;grid-template-columns:2fr 1fr 1fr;gap:40px;margin-bottom:30px;}
.fb{font-family:'Plus Jakarta Sans',sans-serif;font-size:1.35rem;font-weight:800;margin-bottom:8px;display:flex;align-items:center;gap:7px;}
.fb .w{color:#fff;}.fb .p{color:#60a5fa;}
.ftag{font-size:13px;color:#ffffff;line-height:1.7;max-width:250px;}
.fct{font-size:10px;font-weight:800;color:#ffffff;text-transform:uppercase;letter-spacing:1px;margin-bottom:12px;}
.fl a{display:block;color:#ffffff;font-size:13px;margin-bottom:8px;transition:color .18s,padding .18s;}
.fl a:hover{color:#60a5fa;padding-left:4px;}
.fbot{border-top:1px solid rgba(255,255,255,.06);padding-top:16px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:10px;}
.fbot p{font-size:12px;color:#ffffff;}
.fs{display:flex;gap:6px;}
.fs a{width:28px;height:28px;background:rgba(255,255,255,.05);border-radius:7px;display:flex;align-items:center;justify-content:center;color:#ffffff;font-size:13px;border:1px solid rgba(255,255,255,.08);transition:all .18s;}
.fs a:hover{background:var(--blue);color:#fff;transform:translateY(-2px);}

@media(max-width:860px){
  .nlinks{display:none;}
  .hero{height:auto;min-height:420px;}
  .hl{position:relative;width:100%;padding:40px 5% 200px;}
  .hero-bg-shape{display:none;}
  .hr{position:absolute;bottom:0;right:0;width:55%;height:220px;}
  .hr img{height:220px;right:0;}
  .freelancer-badge{right:8px;bottom:8px;}
  .fg{grid-template-columns:1fr;gap:20px;}
  .jcard{flex:0 0 290px;}
}
@media(max-width:560px){
  .hl h1{font-size:1.85rem;}
  .hsr{flex-direction:column;align-items:stretch;}
  .hsbox{max-width:100%;}
  .hr{width:60%;}
}
</style>
</head>
<body>

<!-- NAVBAR -->
<nav class="nav" id="nav">
  <a href="home.jsp" class="logo">
    <svg class="logo-svg" viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg">
      <rect width="34" height="34" rx="9" fill="#2563eb"/>
      <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
      <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
      <line x1="23" y1="24" x2="31" y2="24" stroke="rgba(255,255,255,.4)" stroke-width="1.8" stroke-linecap="round"/>
    </svg>
    <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
  </a>
  <div class="nlinks">
    <div class="ni"><span class="nl">Hire Talent <span class="ca">&#9660;</span></span>
      <div class="dd"><a href="#"><i class="bi bi-plus-circle"></i> Post a Job</a><a href="#"><i class="bi bi-search"></i> Search Talent</a><a href="#"><i class="bi bi-person-check"></i> Talent Hired</a></div>
    </div>
    <div class="ni"><span class="nl">Manage Work <span class="ca">&#9660;</span></span>
      <div class="dd"><a href="#"><i class="bi bi-briefcase"></i> My Jobs</a><a href="#"><i class="bi bi-file-earmark-text"></i> Contracts</a></div>
    </div>
    <div class="ni"><span class="nl">Reports <span class="ca">&#9660;</span></span>
      <div class="dd"><a href="#"><i class="bi bi-bar-chart-line"></i> Weekly Summary</a></div>
    </div>
    
  </div>
  <div class="nr">
    <a href="NotificationServlet" class="nibtn"><i class="bi bi-bell"></i><span class="nbadge"></span></a>
    <a href="WalletServlet" class="nibtn"><i class="bi bi-wallet2"></i></a>
    <a href="ClientProfileServlet" class="nprof">
      <div class="navtr"><%= profile.getName().substring(0,1).toUpperCase() %></div>
      <div><div class="nname"><%= profile.getName() %></div><span class="nrole">Client</span></div>
    </a>
    <form action="LogoutServlet" method="post" style="margin:0">
      <button type="submit" class="nbtn"><i class="bi bi-box-arrow-right"></i> Logout</button>
    </form>
  </div>
</nav>

<!-- ══ HERO — Fiverr-style diagonal split ══ -->
<section class="hero">
  <!-- Right diagonal light background -->
  <div class="hero-bg-shape"></div>

  <!-- Left: content -->
  <div class="hl">
    <div class="hwelcome"><span class="wd"></span> Welcome back, <strong><%= profile.getName() %></strong></div>
    <h1>Find &amp; Hire<br><span class="ac">Expert Freelancers</span></h1>
    <p class="hsub">Work with the best freelance talent on our secure, flexible and cost-effective platform. Post a project and start hiring today.</p>
    <div class="hsr">
      <div class="hsbox"><i class="bi bi-search"></i><input type="text" placeholder="What skill are you looking for?"></div>
      <span class="hor">Or</span>
      <% if (profileComplete) { %>
        <a href="post_job_title.jsp" class="btnp"><i class="bi bi-plus-lg"></i> Post a Job &mdash; It&apos;s Free</a>
      <% } else { %>
        <button class="btnp dis" onclick="alert('Please complete your profile first!')"><i class="bi bi-lock"></i> Post a Job</button>
      <% } %>
    </div>
    <div class="chips">
      <span class="chip">Web Development</span><span class="chip">UI/UX Design</span>
      <span class="chip">Logo Design</span><span class="chip">SEO</span><span class="chip">Content Writing</span>
    </div>
    <div><a href="ClientProfileServlet" class="btng"><i class="bi bi-person-circle"></i> View My Profile</a></div>
  </div>

  <!-- Right: professional freelancer person image (cutout/PNG style like Fiverr) -->
  <div class="hr">
    <img
      src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=600&q=85&sat=-20"
      alt="Professional freelancer"
    >
    <!-- Fiverr-style name badge at bottom -->
    <div class="freelancer-badge">
      <div>
        <div class="fb-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
        <div class="fb-name">Priya S.</div>
        <div class="fb-role">UI/UX Designer</div>
      </div>
    </div>
  </div>
</section>

<!-- ══ POPULAR PROFESSIONAL SERVICES (replaces slider) ══ -->
<section class="services-sec">
  <div class="services-sec-title">Popular Professional Services</div>
  <div class="services-grid">

    <div class="svc-card">
      <img class="svc-card-bg" src="https://images.unsplash.com/photo-1561070791-2526d30994b5?auto=format&fit=crop&w=400&h=300&q=80" alt="Logo Design">
      <div class="svc-card-overlay">
        <div class="svc-card-sub">Build Your Brand</div>
        <div class="svc-card-name">Logo Design</div>
      </div>
    </div>

    <div class="svc-card">
      <img class="svc-card-bg" src="https://images.unsplash.com/photo-1467232004584-a241de8bcf5d?auto=format&fit=crop&w=400&h=300&q=80" alt="WordPress">
      <div class="svc-card-overlay">
        <div class="svc-card-sub">Customize Your Site</div>
        <div class="svc-card-name">WordPress</div>
      </div>
    </div>

    <div class="svc-card">
      <img class="svc-card-bg" src="https://images.unsplash.com/photo-1478737270239-2f02b77fc618?auto=format&fit=crop&w=400&h=300&q=80" alt="Voice Over">
      <div class="svc-card-overlay">
        <div class="svc-card-sub">Share Your Message</div>
        <div class="svc-card-name">Voice Over</div>
      </div>
    </div>

    <div class="svc-card">
      <img class="svc-card-bg" src="https://images.unsplash.com/photo-1611532736597-de2d4265fba3?auto=format&fit=crop&w=400&h=300&q=80" alt="Social Media">
      <div class="svc-card-overlay">
        <div class="svc-card-sub">Reach More Customers</div>
        <div class="svc-card-name">Social Media</div>
      </div>
    </div>

    <div class="svc-card">
      <img class="svc-card-bg" src="https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=400&h=300&q=80" alt="Web Development">
      <div class="svc-card-overlay">
        <div class="svc-card-sub">Grow Your Business</div>
        <div class="svc-card-name">Web Development</div>
      </div>
    </div>

    <div class="svc-card">
      <img class="svc-card-bg" src="https://images.unsplash.com/photo-1542744094-24638eff58bb?auto=format&fit=crop&w=400&h=300&q=80" alt="SEO">
      <div class="svc-card-overlay">
        <div class="svc-card-sub">Rank Higher</div>
        <div class="svc-card-name">SEO</div>
      </div>
    </div>

    <div class="svc-card">
      <img class="svc-card-bg" src="https://images.unsplash.com/photo-1587440871875-191322ee64b0?auto=format&fit=crop&w=400&h=300&q=80" alt="Video Editing">
      <div class="svc-card-overlay">
        <div class="svc-card-sub">Tell Your Story</div>
        <div class="svc-card-name">Video Editing</div>
      </div>
    </div>
    
    <div class="svc-card">
  <img class="svc-card-bg" src="https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3?auto=format&fit=crop&w=400&h=300&q=80" alt="Data Analytics">
  <div class="svc-card-overlay">
    <div class="svc-card-sub">Make Smarter Decisions</div>
    <div class="svc-card-name">Data Analytics</div>
  </div>
</div>

<div class="svc-card">
  <img class="svc-card-bg" src="https://images.unsplash.com/photo-1526378800651-c32d170fe6f8?auto=format&fit=crop&w=400&h=300&q=80" alt="Mobile App Development">
  <div class="svc-card-overlay">
    <div class="svc-card-sub">Go Mobile First</div>
    <div class="svc-card-name">App Development</div>
  </div>
</div>


  </div>
</section>

<!-- PAGE CONTENT -->
<div class="pw">
  <% if (!profileComplete) { %>
  <div class="ib rv">
    <i class="bi bi-exclamation-triangle-fill"></i>
    <div><strong>Profile is <%= completed %>% complete</strong><p>Add phone, company name &amp; bio to unlock project posting.</p></div>
    <div class="ibr"><span><%= completed %>/100%</span><div class="pb"><div class="pf" style="width:<%= completed %>%"></div></div></div>
    <a href="ClientProfileServlet" class="bcomp">Complete &rarr;</a>
  </div>
  <% } %>

  <!-- ACTIVE LISTINGS -->
  <div class="sh rv">
    <div class="sht"><div class="shi"><i class="bi bi-broadcast-pin"></i></div>Active Listings</div>
    <span class="shb"><%= activeCount %> project<%= activeCount!=1?"s":"" %></span>
  </div>

  <div class="card-scroll-wrap rv">
    <button class="row-arr row-arr-l" onclick="scrollRow('activeRow',-1)"><i class="bi bi-chevron-left"></i></button>
    <div class="card-row" id="activeRow">
      <% if (activeJobs == null || activeJobs.isEmpty()) { %>
        <div class="empty"><div class="ei"><i class="bi bi-folder2-open"></i></div><h4>No active listings yet</h4><p>Post your first project to start receiving bids.</p></div>
      <% } else {
           for (Job job : activeJobs) {
             String st = (job.getTitle()!=null)?job.getTitle().replace("&","&amp;").replace("\"","&quot;"):"";
             String sb = String.valueOf(job.getBudget());
             String sd = (job.getDuration()!=null)?job.getDuration().replace("\"","&quot;"):"";
             String sl = (job.getFreelancerLevel()!=null)?job.getFreelancerLevel().replace("\"","&quot;"):"";
             String sc2= (job.getComplexity()!=null)?job.getComplexity().replace("\"","&quot;"):"";
             String sde= (job.getDescription()!=null)?job.getDescription().replace("&","&amp;").replace("\"","&quot;").replace("<","&lt;"):"";
      %>
        <div class="jcard">
          <div class="jcard-top">
            <div class="jcard-ico"><i class="bi bi-briefcase"></i></div>
            <div class="jcard-title-wrap">
              <div class="jcard-name"><%= job.getTitle() %></div>
              <span class="jcard-status-badge badge-blue">Active listing</span>
            </div>
            <button class="jcard-menu">&#8230;</button>
          </div>
          <div class="jcard-meta">
            <span><i class="bi bi-currency-rupee"></i>&#8377;<%= job.getBudget() %></span>
            <span><i class="bi bi-clock"></i><%= job.getDuration() %></span>
          </div>
          <div class="jcard-desc"><%= (job.getDescription()!=null&&!job.getDescription().isEmpty())?job.getDescription():"No description provided." %></div>
          <div class="jcard-actions">
            <button class="bv" data-title="<%= st %>" data-budget="<%= sb %>" data-dur="<%= sd %>" data-level="<%= sl %>" data-comp="<%= sc2 %>" data-desc="<%= sde %>" onclick="openJM(this)"><i class="bi bi-eye"></i> View</button>
            <form action="DeleteJobServlet" method="post" style="margin:0;flex:1;" onsubmit="return confirm('Remove this project?');">
              <input type="hidden" name="jobId" value="<%= job.getJobId() %>">
              <button type="submit" class="bd" style="width:100%;"><i class="bi bi-trash3"></i> Remove</button>
            </form>
          </div>
        </div>
      <% } } %>
      <% if (profileComplete) { %>
        <a href="post_job_title.jsp" class="post-card">
          <i class="bi bi-plus-circle"></i><span>Post a job</span>
        </a>
      <% } else { %>
        <div class="post-card" onclick="alert('Complete your profile first!')">
          <i class="bi bi-plus-circle"></i><span>Post a job</span>
        </div>
      <% } %>
    </div>
    <button class="row-arr row-arr-r" onclick="scrollRow('activeRow',1)"><i class="bi bi-chevron-right"></i></button>
  </div>

  <hr class="div">

  <!-- ONGOING PROJECTS — matches Active Listings layout exactly -->

<%-- Section header --%>
<div class="sh rv">
  <div class="sht"><div class="shi"><i class="bi bi-person-workspace"></i></div>Ongoing Projects</div>
  <span class="shb"><%= (workingJobs != null ? workingJobs.size() : 0) %> project<%= (workingJobs != null && workingJobs.size() == 1) ? "" : "s" %></span>
</div>

<%-- Scrollable card row with arrows --%>
<div class="card-scroll-wrap rv">
  <button class="row-arr row-arr-l" onclick="scrollRow('ongoingRow',-1)"><i class="bi bi-chevron-left"></i></button>

  <div class="card-row" id="ongoingRow">

    <%
    if (workingJobs == null || workingJobs.isEmpty()) {
    %>
      <div class="empty">
        <div class="ei"><i class="bi bi-gear"></i></div>
        <h4>No ongoing projects</h4>
        <p>Once you hire a freelancer, active work appears here.</p>
      </div>
    <%
    } else {
        EscrowService escrowService = new EscrowService();
        int clientSessionId = Integer.parseInt(session.getAttribute("id").toString());

        for (Job job : workingJobs) {
            String st  = (job.getTitle()!=null)           ? job.getTitle().replace("&","&amp;").replace("\"","&quot;")                                                  : "";
            String sb  = String.valueOf(job.getBudget());
            String sd  = (job.getDuration()!=null)        ? job.getDuration().replace("\"","&quot;")                                                                    : "";
            String sl  = (job.getFreelancerLevel()!=null) ? job.getFreelancerLevel().replace("\"","&quot;")                                                             : "";
            String sc2 = (job.getComplexity()!=null)      ? job.getComplexity().replace("\"","&quot;")                                                                  : "";
            String sde = (job.getDescription()!=null)     ? job.getDescription().replace("&","&amp;").replace("\"","&quot;").replace("<","&lt;")                       : "";

            java.util.Map<String,Object> escrow = null;
            try { escrow = escrowService.getEscrowByJob(job.getJobId()); } catch(Exception ignore) {}
            boolean escrowHeld     = escrow != null && "HELD".equals(escrow.get("status"));
            boolean escrowReleased = escrow != null && "RELEASED".equals(escrow.get("status"));
            java.math.BigDecimal escrowAmt = escrow != null ? (java.math.BigDecimal) escrow.get("amount") : java.math.BigDecimal.ZERO;
    %>
      <div class="jcard og">

        <%-- Card top --%>
        <div class="jcard-top">
          <div class="jcard-ico" style="background:#f0fdf4;border-color:#bbf7d0;color:#15803d;">
            <i class="bi bi-person-workspace"></i>
          </div>
          <div class="jcard-title-wrap">
            <div class="jcard-name"><%= job.getTitle() %></div>
            <span class="jcard-status-badge badge-green">In Progress</span>
          </div>
          <button class="jcard-menu">&#8230;</button>
        </div>

        <%-- Meta row --%>
        <div class="jcard-meta">
          <span><i class="bi bi-currency-rupee"></i>&#8377;<%= job.getBudget() %></span>
          <span><i class="bi bi-clock"></i><%= job.getDuration() %></span>
          <% if (escrowHeld) { %>
            <span style="background:#fef9c3;color:#854d0e;border-color:#fef08a;">
              <i class="bi bi-lock-fill" style="color:#b45309;"></i>
              &#8377;<%= escrowAmt %> in escrow
            </span>
          <% } else if (escrowReleased) { %>
            <span style="background:#dcfce7;color:#15803d;border-color:#bbf7d0;">
              <i class="bi bi-check-circle-fill"></i> Payment released
            </span>
          <% } %>
        </div>

        <%-- Description --%>
        <div class="jcard-desc">
          <%= (job.getDescription()!=null && !job.getDescription().isEmpty()) ? job.getDescription() : "No description provided." %>
        </div>

        <%-- Actions --%>
        <div class="jcard-actions">

          <%-- Chat --%>
          <a href="ChatServlet?jobId=<%= job.getJobId() %>"
             style="text-decoration:none;flex:1;justify-content:center;display:inline-flex;align-items:center;gap:5px;padding:9px 14px;border-radius:var(--rs);font-size:13px;font-weight:700;font-family:'DM Sans',sans-serif;border:1.5px solid #bbf7d0;background:#f0fdf4;color:#15803d;transition:transform .2s,box-shadow .2s,background .2s,color .2s,border-color .2s;white-space:nowrap;">
            <i class="bi bi-chat-dots-fill"></i> Chat
          </a>

          <%-- Details --%>
          <button class="bv"
            data-title="<%= st %>" data-budget="<%= sb %>"
            data-dur="<%= sd %>"  data-level="<%= sl %>"
            data-comp="<%= sc2 %>" data-desc="<%= sde %>"
            onclick="openJM(this)">
            <i class="bi bi-eye"></i> Details
          </button>

          <%-- Release Payment — only when escrow HELD --%>
          <% if (escrowHeld) { %>
            <form action="ReleasePaymentServlet" method="post" style="margin:0;flex:1;"
                  onsubmit="return confirm('Release &#8377;<%= escrowAmt %> to the freelancer and mark this project as completed?');">
              <input type="hidden" name="jobId" value="<%= job.getJobId() %>">
              <button type="submit"
    style="width:100%;display:inline-flex;align-items:center;justify-content:center;gap:5px;padding:9px 14px;border-radius:var(--rs);font-size:13px;font-weight:700;font-family:'DM Sans',sans-serif;border:1.5px solid #fbbf24;background:#fef9c3;color:#92400e;cursor:pointer;transition:all .2s;white-space:nowrap;"
    onmouseover="this.style.background='#f59e0b';this.style.color='#fff';this.style.borderColor='#d97706';"
    onmouseout="this.style.background='#fef9c3';this.style.color='#92400e';this.style.borderColor='#fbbf24';">
    
    Release &#8377;<%= escrowAmt %>
</button>
            </form>
          <% } %>

        </div>
      </div>
    <%
        } // end for
    } // end else
    %>

  </div><%-- end #ongoingRow --%>

  <button class="row-arr row-arr-r" onclick="scrollRow('ongoingRow',1)"><i class="bi bi-chevron-right"></i></button>
</div>

<hr class="div">

  <!-- RESOURCE CENTER -->
  <div class="sh rv">
    <div class="sht"><div class="shi" style="background:#f5f3ff;color:var(--violet);"><i class="bi bi-book-half"></i></div>Resource Center</div>
  </div>
  <div class="rg">
    <div class="rc rv d1" onclick="openRM('howTo')">
      <i class="bi bi-arrow-up-right ra"></i>
      <div class="ri rib"><i class="bi bi-person-plus-fill"></i></div>
      <h3>How to Hire</h3>
      <p>Best practices for finding and onboarding the right freelancer for your goals.</p>
    </div>
    <div class="rc rv d2" onclick="openRM('payments')">
      <i class="bi bi-arrow-up-right ra"></i>
      <div class="ri ric"><i class="bi bi-credit-card-2-front-fill"></i></div>
      <h3>Payments</h3>
      <p>Secure, encrypted payments with escrow protection for every milestone.</p>
    </div>
    <div class="rc rv d3" onclick="openRM('safety')">
      <i class="bi bi-arrow-up-right ra"></i>
      <div class="ri riv"><i class="bi bi-shield-fill-check"></i></div>
      <h3>Trust &amp; Safety</h3>
      <p>How we protect your data and ensure a safe environment for business.</p>
    </div>
  </div>

</div>

<!-- FOOTER -->
<footer class="ft">
  <div class="fg">
    <div>
      <div class="fb">
        <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:26px;height:26px;flex-shrink:0;">
          <rect width="34" height="34" rx="9" fill="#2563eb"/>
          <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
          <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
          <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
        </svg>
        <span class="w">Work</span><span class="p">Port</span>
      </div>
      <p class="ftag">Connecting businesses with top-tier global talent — securely, quickly, at scale.</p>
    </div>
    <div><div class="fct">Support</div><div class="fl"><a href="#">Help Center</a><a href="#">Safety &amp; Security</a><a href="#">Privacy Policy</a></div></div>
    <div><div class="fct">Company</div><div class="fl"><a href="#">About Us</a><a href="#">Careers</a><a href="#">Blog</a></div></div>
  </div>
  <div class="fbot">
    <p>&copy; 2025 WorkPort Technologies. All rights reserved. | Made by Prem Vikas Yadav</p>
    <div class="fs"><a href="#"><i class="bi bi-twitter-x"></i></a><a href="#"><i class="bi bi-linkedin"></i></a><a href="#"><i class="bi bi-github"></i></a></div>
  </div>
</footer>

<!-- RESOURCE MODAL -->
<div id="rmO" class="mo">
  <div class="mb"><button class="mc" onclick="closeRM()"><i class="bi bi-x"></i></button><div id="rmB"></div></div>
</div>

<!-- JOB MODAL -->
<div id="jmO" class="mo">
  <div class="mb">
    <button class="mc" onclick="closeJM()"><i class="bi bi-x"></i></button>
    <div class="mtp"><div class="mtt" id="jmT"></div><div class="mts">Project Overview</div></div>
    <div class="dr"><div class="di"><i class="bi bi-currency-rupee"></i></div><div><div class="dl">Budget</div><div class="dv">&#8377;<span id="jmB"></span></div></div></div>
    <div class="dr"><div class="di"><i class="bi bi-clock"></i></div><div><div class="dl">Duration</div><div class="dv" id="jmD"></div></div></div>
    <div class="dr"><div class="di"><i class="bi bi-person-badge"></i></div><div><div class="dl">Freelancer Level</div><div class="dv" id="jmL"></div></div></div>
    <div class="dr"><div class="di"><i class="bi bi-layers"></i></div><div><div class="dl">Complexity</div><div class="dv" id="jmC"></div></div></div>
    <div class="dr" style="flex-direction:column;gap:0;">
      <div style="display:flex;align-items:center;gap:9px;"><div class="di"><i class="bi bi-file-text"></i></div><div class="dl">Description</div></div>
      <div class="dd2" id="jmDe"></div>
    </div>
  </div>
</div>

<script>
window.addEventListener('scroll',function(){document.getElementById('nav').classList.toggle('sc',window.scrollY>30);});

var obs=new IntersectionObserver(function(entries){entries.forEach(function(e){if(e.isIntersecting){e.target.classList.add('on');obs.unobserve(e.target);}});},{threshold:0.08});
document.querySelectorAll('.rv').forEach(function(el){obs.observe(el);});

function scrollRow(id,dir){document.getElementById(id).scrollBy({left:dir*380,behavior:'smooth'});}

var res={
  howTo:{title:'How to Hire',icon:'bi-person-plus-fill',color:'#2563eb',bg:'#eff6ff',items:[{t:'Post a clear job',d:'Be specific about deliverables, skills, timeline and budget.'},{t:'Evaluate bids',d:'Review portfolios and ratings before shortlisting.'},{t:'Communicate early',d:'Clarify requirements before making the hire.'}]},
  payments:{title:'Secure Payments',icon:'bi-credit-card-2-front-fill',color:'#06b6d4',bg:'#ecfeff',items:[{t:'Escrow protection',d:'Funds held securely until you approve completed work.'},{t:'Milestone releases',d:'Release payments as milestones are verified.'}]},
  safety:{title:'Trust & Safety',icon:'bi-shield-fill-check',color:'#8b5cf6',bg:'#f5f3ff',items:[{t:'Encryption',d:'All data encrypted with AES-256 standard.'},{t:'Verified profiles',d:'Every freelancer undergoes identity verification.'}]}
};
function openRM(t){var r=res[t];var h='<div class="mtp"><div style="display:flex;align-items:center;gap:9px;margin-bottom:3px;"><div style="width:32px;height:32px;border-radius:8px;background:'+r.bg+';display:flex;align-items:center;justify-content:center;font-size:15px;color:'+r.color+';"><i class="bi '+r.icon+'"></i></div><div class="mtt">'+r.title+'</div></div><div class="mts">Resource Guide</div></div>';r.items.forEach(function(i){h+='<div style="padding:10px 0;border-bottom:1px solid #f3f4f6;"><div style="font-weight:700;font-size:13px;color:#1f2937;margin-bottom:3px;">'+i.t+'</div><div style="font-size:12.5px;color:#9ca3af;line-height:1.6;">'+i.d+'</div></div>';});document.getElementById('rmB').innerHTML=h;document.getElementById('rmO').classList.add('open');}
function closeRM(){document.getElementById('rmO').classList.remove('open');}
document.getElementById('rmO').addEventListener('click',function(e){if(e.target===this)closeRM();});

function openJM(b){document.getElementById('jmT').textContent=b.getAttribute('data-title');document.getElementById('jmB').textContent=b.getAttribute('data-budget');document.getElementById('jmD').textContent=b.getAttribute('data-dur');document.getElementById('jmL').textContent=b.getAttribute('data-level');document.getElementById('jmC').textContent=b.getAttribute('data-comp');document.getElementById('jmDe').textContent=b.getAttribute('data-desc');document.getElementById('jmO').classList.add('open');}
function closeJM(){document.getElementById('jmO').classList.remove('open');}
document.getElementById('jmO').addEventListener('click',function(e){if(e.target===this)closeJM();});
</script>
</body>
</html>
