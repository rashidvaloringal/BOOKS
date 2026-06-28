// api/config.js
export default function handler(req, res) {
  // Allow CORS for your domain
  res.setHeader('Access-Control-Allow-Origin', '*');
  
  res.status(200).json({
    url: process.env.SUPABASE_URL,
    key: process.env.SUPABASE_KEY
  });
}
