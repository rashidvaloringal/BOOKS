// /api/config.js - Vercel Serverless Function
export default function handler(req, res) {
  // നിങ്ങളുടെ Vercel Dashboard-ൽ നൽകിയ Environment Variables ഇവിടെ സുരക്ഷിതമായി റീഡ് ചെയ്യപ്പെടുന്നു
  res.status(200).json({
    supabaseUrl: process.env.SUPABASE_URL || "https://axjeqkeocbfemojomfjm.supabase.co",
    supabaseKey: process.env.SUPABASE_KEY || "sb_publishable_JgdXpn2s46NfLu0wNHU_9w_Cj9ewUKE"
  });
}
