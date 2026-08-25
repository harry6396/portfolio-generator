#!/bin/bash

# Initialize package.json
cat << 'EOF' > package.json
{
  "name": "portfolio-generator",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "build:vivekanand": "NEXT_PUBLIC_PERSONA=vivekanand-07128411 next build",
    "build:anshul": "NEXT_PUBLIC_PERSONA=anshulbh9 next build",
    "build:chandrima": "NEXT_PUBLIC_PERSONA=chandrima-das-6b7b63192 next build"
  },
  "dependencies": {
    "next": "^14.2.0",
    "react": "^18.3.0",
    "react-dom": "^18.3.0"
  }
}
EOF

# Create next.config.mjs for static export
cat << 'EOF' > next.config.mjs
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  images: {
    unoptimized: true,
  },
};

export default nextConfig;
EOF

# Create directory structure
mkdir -p src/app
mkdir -p src/lib
mkdir -p data/personas/vivekanand-07128411
mkdir -p data/personas/anshulbh9
mkdir -p data/personas/chandrima-das-6b7b63192

# Populate Persona 1 Data
cat << 'EOF' > data/personas/vivekanand-07128411/profile.json
{
  "name": "Vivekanand",
  "title": "Software Professional",
  "bio": "Experienced software practitioner focused on building reliable, scalable enterprise applications and solutions.",
  "linkedin": "https://www.linkedin.com/in/vivekanand-07128411/",
  "skills": ["Software Engineering", "System Design", "Architecture", "Cloud Native"],
  "projects": [
    {
      "title": "Enterprise Application Suite",
      "description": "High-throughput application framework built for resilience and distributed operations."
    }
  ]
}
EOF

# Populate Persona 2 Data
cat << 'EOF' > data/personas/anshulbh9/profile.json
{
  "name": "Anshul Bhatnagar",
  "title": "Engineering Lead & Platform Engineer",
  "bio": "Specializing in distributed systems, developer tooling, cloud-native architecture, and web development.",
  "linkedin": "https://www.linkedin.com/in/anshulbh9/",
  "skills": ["React", "Next.js", "Node.js", "TypeScript", "Kubernetes", "Go"],
  "projects": [
    {
      "title": "Dynamic Portfolio Engine",
      "description": "Multi-tenant static site generation workflow powered by Next.js environment configurations."
    }
  ]
}
EOF

# Populate Persona 3 Data
cat << 'EOF' > data/personas/chandrima-das-6b7b63192/profile.json
{
  "name": "Chandrima Das",
  "title": "Technology Professional",
  "bio": "Passionate technology innovator with strong experience across modern stack implementations and delivery.",
  "linkedin": "https://www.linkedin.com/in/chandrima-das-6b7b63192/",
  "skills": ["Frontend Development", "JavaScript", "React", "User Experience design"],
  "projects": [
    {
      "title": "User Centric Web Experience",
      "description": "Designed accessible web interfaces optimized for responsiveness and fast static rendering."
    }
  ]
}
EOF

# Create data loader utility
cat << 'EOF' > src/lib/getPersonaData.js
import fs from 'fs';
import path from 'path';

export function getPersonaData() {
  const targetPersona = process.env.NEXT_PUBLIC_PERSONA || 'anshulbh9';
  const filePath = path.join(process.cwd(), 'data', 'personas', targetPersona, 'profile.json');

  if (!fs.existsSync(filePath)) {
    throw new Error(`Profile data not found for persona: ${targetPersona}`);
  }

  const fileContents = fs.readFileSync(filePath, 'utf8');
  return JSON.parse(fileContents);
}
EOF

# Create App Router Layout
cat << 'EOF' > src/app/layout.js
export const metadata = {
  title: 'Portfolio Engine',
  description: 'Persona-driven static portfolio generator',
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body style={{ margin: 0, padding: 0, fontFamily: 'system-ui, sans-serif', backgroundColor: '#f9fafb' }}>
        {children}
      </body>
    </html>
  );
}
EOF

# Create main page component
cat << 'EOF' > src/app/page.js
import { getPersonaData } from '@/lib/getPersonaData';

export default function Home() {
  const profile = getPersonaData();

  return (
    <main style={{ maxWidth: '750px', margin: '40px auto', padding: '2rem', backgroundColor: '#ffffff', borderRadius: '8px', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
      <header style={{ borderBottom: '1px solid #e5e7eb', paddingBottom: '1.5rem' }}>
        <h1 style={{ fontSize: '2.25rem', margin: '0 0 0.5rem 0', color: '#111827' }}>{profile.name}</h1>
        <p style={{ fontSize: '1.25rem', color: '#4b5563', margin: '0 0 1rem 0' }}>{profile.title}</p>
        <a 
          href={profile.linkedin} 
          target="_blank" 
          rel="noopener noreferrer" 
          style={{ color: '#2563eb', textDecoration: 'none', fontWeight: '500' }}
        >
          View LinkedIn Profile &rarr;
        </a>
      </header>

      <section style={{ margin: '2rem 0' }}>
        <h2 style={{ fontSize: '1.5rem', color: '#1f2937' }}>About</h2>
        <p style={{ color: '#374151', lineHeight: '1.6' }}>{profile.bio}</p>
      </section>

      <section style={{ margin: '2rem 0' }}>
        <h2 style={{ fontSize: '1.5rem', color: '#1f2937' }}>Skills</h2>
        <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap' }}>
          {profile.skills.map((skill, index) => (
            <span key={index} style={{ background: '#f3f4f6', color: '#374151', padding: '0.4rem 0.8rem', borderRadius: '9999px', fontSize: '0.875rem' }}>
              {skill}
            </span>
          ))}
        </div>
      </section>

      <section style={{ margin: '2rem 0' }}>
        <h2 style={{ fontSize: '1.5rem', color: '#1f2937' }}>Key Projects</h2>
        {profile.projects.map((project, index) => (
          <div key={index} style={{ border: '1px solid #e5e7eb', padding: '1rem', borderRadius: '6px', marginBottom: '1rem' }}>
            <h3 style={{ margin: '0 0 0.5rem 0', color: '#111827' }}>{project.title}</h3>
            <p style={{ margin: 0, color: '#4b5563', fontSize: '0.95rem' }}>{project.description}</p>
          </div>
        ))}
      </section>
    </main>
  );
}
EOF

echo "Project files generated successfully!"
