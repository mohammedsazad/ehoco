 "use client";
import {useState} from "react";
export default function VideoPopup({url}){const [open,setOpen]=useState(false);return <>{<button className="floatVideo" onClick={e=>{e.preventDefault();setOpen(true)}}><video src={url} autoPlay muted loop playsInline/></button>}{open&&<div className="videoOverlay" onClick={()=>setOpen(false)}><div className="videoModal" onClick={e=>e.stopPropagation()}><button className="closeVideo" onClick={()=>setOpen(false)}>×</button><video src={url} controls autoPlay playsInline/></div></div>}</>}
