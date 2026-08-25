import fs from 'fs';
import path from 'path';

export function getPersonaData() {
  const targetPersona = process.env.NEXT_PUBLIC_PERSONA || 'anshulbh9';
  const personaDir = path.join(process.cwd(), 'data', 'personas', targetPersona);

  const enhancedPath = path.join(personaDir, 'profile.enhanced.json');
  const rawPath = path.join(personaDir, 'profile.json');

  let filePath = fs.existsSync(enhancedPath) ? enhancedPath : rawPath;

  if (!fs.existsSync(filePath)) {
    throw new Error(`Profile data not found for persona: ${targetPersona}`);
  }

  const fileContents = fs.readFileSync(filePath, 'utf8');
  const parsed = JSON.parse(fileContents);

  const data = parsed.rawLinkedInData || parsed;

  return {
    name: data.name || '',
    title: data.title || '',
    bio: data.bio || '',
    linkedin: data.linkedin || '#',
    skills: Array.isArray(data.skills) ? data.skills : [],
    experience: Array.isArray(data.experience) ? data.experience : [],
    projects: Array.isArray(data.projects) ? data.projects : [],
  };
}
