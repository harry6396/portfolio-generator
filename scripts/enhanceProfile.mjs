import fs from 'fs';
import path from 'path';
import { GoogleGenAI } from '@google/genai';

// Initialize SDK (uses GEMINI_API_KEY from process.env)
const ai = new GoogleGenAI({});

const persona = process.env.PERSONA_NAME || 'anshulbh9';
const personaDir = path.join(process.cwd(), 'data', 'personas', persona);
const pdfPath = path.join(personaDir, 'Profile.pdf');
const outputPath = path.join(personaDir, 'profile.enhanced.json');

async function processPdfProfile() {
  if (!fs.existsSync(pdfPath)) {
    console.error(`❌ File not found: ${pdfPath}`);
    process.exit(1);
  }

  console.log(`📄 Processing PDF for ${persona}...`);

  // Read PDF binary buffer and convert directly to base64
  const pdfBuffer = fs.readFileSync(pdfPath);
  const base64Pdf = pdfBuffer.toString('base64');

  const prompt = `
    Analyze the attached LinkedIn profile PDF. 
    Extract the exact professional data and output it as structured JSON for a developer portfolio site.

    CRITICAL RULES:
    1. Do NOT invent, assume, or add skills, projects, or employment history not present in the PDF.
    2. Polish bios and role descriptions into concise, clear professional bullet points/paragraphs.
    3. Output strictly valid JSON matching this schema:
    {
      "name": "Full Name",
      "title": "Headline / Current Role Title",
      "bio": "A concise overview based on their about section and experience",
      "linkedin": "Full LinkedIn URL if visible, else empty string",
      "skills": ["Skill1", "Skill2"],
      "experience": [
        {
          "role": "Job Title",
          "company": "Company Name",
          "period": "Start Date - End Date",
          "description": "Key responsibilities and achievements"
        }
      ],
      "projects": [
        {
          "title": "Project Name",
          "description": "Brief details",
          "tags": ["Tech", "Stack"]
        }
      ]
    }
  `;

  try {
    const response = await ai.models.generateContent({
      model: 'gemini-3.6-flash', // Updated model ID
      contents: [
        {
          inlineData: {
            mimeType: 'application/pdf',
            data: base64Pdf,
          },
        },
        { text: prompt },
      ],
      config: {
        responseMimeType: 'application/json',
      },
    });

    // Strip Markdown code fences if present in the response string
    let cleanJson = response.text || '';
    cleanJson = cleanJson.replace(/^```json\s*/i, '').replace(/\s*```$/i, '').trim();

    // Parse to ensure valid JSON before writing to disk
    JSON.parse(cleanJson);

    fs.writeFileSync(outputPath, cleanJson, 'utf8');
    console.log(`✅ Successfully generated ${outputPath}`);
  } catch (error) {
    console.error('❌ Failed to process PDF:', error);
  }
}

processPdfProfile();
