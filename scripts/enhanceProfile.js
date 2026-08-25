import fs from 'fs';
import path from 'path';
import { GoogleGenAI } from '@google/genai';

const ai = new GoogleGenAI(); // Reads API key from environment variable

const persona = process.env.PERSONA_NAME || 'anshulbh9';
const profilePath = path.join(process.cwd(), 'data', 'personas', persona, 'profile.json');
const outputPath = path.join(process.cwd(), 'data', 'personas', persona, 'profile.enhanced.json');

async function enhanceProfileData() {
  const fileContent = fs.readFileSync(profilePath, 'utf8');
  const { rawLinkedInData } = JSON.parse(fileContent);

  const prompt = `
    You are an expert technical resume editor. 
    Enhance the following LinkedIn profile data for a modern web portfolio.
    
    STRICT RULES:
    1. Do NOT hallucinate or add any new skills, experiences, or claims that are not present in the input.
    2. Enhance the 'bio' and 'experience descriptions' to make them impactful, concise, and professional.
    3. Keep all names, links, skills, and dates EXACTLY as provided.
    4. Output ONLY valid JSON following this structure:
       {
         "name": "string",
         "title": "string",
         "bio": "string",
         "linkedin": "string",
         "skills": ["string"],
         "experience": [{"role": "string", "company": "string", "period": "string", "description": "string"}]
       }

    Input Data:
    ${JSON.stringify(rawLinkedInData, null, 2)}
  `;

  const response = await ai.models.generateContent({
    model: 'gemini-3.6-flash',
    contents: prompt,
    config: {
      responseMimeType: 'application/json',
    },
  });

  fs.writeFileSync(outputPath, response.text);
  console.log(`✅ Profile successfully enhanced and saved to ${outputPath}`);
}

enhanceProfileData().catch(console.error);
