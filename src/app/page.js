import { getPersonaData } from '../lib/getPersonaData';

export default function Home() {
  const profile = getPersonaData();

  // Defensive checks with fallback defaults
  const name = profile?.name || 'Anonymous';
  const title = profile?.title || 'Professional';
  const bio = profile?.bio || '';
  const linkedin = profile?.linkedin || '#';
  const skills = profile?.skills || [];
  const experience = profile?.experience || [];
  const projects = profile?.projects || [];

  return (
    <div style={styles.container}>
      <div style={styles.bgGlowContainer}>
        <div style={{ ...styles.bgGlow, top: '-10%', left: '-10%', background: 'radial-gradient(circle, rgba(99,102,241,0.15) 0%, rgba(0,0,0,0) 70%)' }} />
        <div style={{ ...styles.bgGlow, bottom: '-10%', right: '-10%', background: 'radial-gradient(circle, rgba(168,85,247,0.15) 0%, rgba(0,0,0,0) 70%)' }} />
      </div>

      <div style={styles.wrapper}>
        <nav style={styles.nav}>
          <span style={styles.logo}>{name.split(' ')[0]}.dev</span>
          {linkedin !== '#' && (
            <a href={linkedin} target="_blank" rel="noopener noreferrer" style={styles.linkedinBadge}>
              LinkedIn Profile ↗
            </a>
          )}
        </nav>

        <section style={styles.hero}>
          <div style={styles.badge}>Available for Next Opportunities</div>
          <h1 style={styles.heroTitle}>{name}</h1>
          <p style={styles.heroSubtitle}>{title}</p>
          <p style={styles.heroBio}>{bio}</p>
        </section>

        {skills.length > 0 && (
          <section style={styles.section}>
            <h2 style={styles.sectionTitle}>Core Expertise</h2>
            <div style={styles.skillsGrid}>
              {skills.map((skill, index) => (
                <span key={index} style={styles.skillCard}>
                  {skill}
                </span>
              ))}
            </div>
          </section>
        )}

        {experience.length > 0 && (
          <section style={styles.section}>
            <h2 style={styles.sectionTitle}>Experience</h2>
            <div style={styles.timeline}>
              {experience.map((item, index) => (
                <div key={index} style={styles.timelineCard}>
                  <div style={styles.timelineHeader}>
                    <h3 style={styles.roleTitle}>{item.role || item.title}</h3>
                    <span style={styles.period}>{item.period || item.dates}</span>
                  </div>
                  <p style={styles.companyName}>{item.company}</p>
                  <p style={styles.timelineDesc}>{item.description}</p>
                </div>
              ))}
            </div>
          </section>
        )}

        {projects.length > 0 && (
          <section style={styles.section}>
            <h2 style={styles.sectionTitle}>Featured Projects</h2>
            <div style={styles.projectsGrid}>
              {projects.map((project, index) => (
                <div key={index} style={styles.projectCard}>
                  <h3 style={styles.projectTitle}>{project.title}</h3>
                  <p style={styles.projectDesc}>{project.description}</p>
                  {project.tags?.length > 0 && (
                    <div style={styles.projectTags}>
                      {project.tags.map((tag, idx) => (
                        <span key={idx} style={styles.tag}>{tag}</span>
                      ))}
                    </div>
                  )}
                </div>
              ))}
            </div>
          </section>
        )}

        <footer style={styles.footer}>
          <p>© {new Date().getFullYear()} {name}. Built with Next.js & Express.</p>
        </footer>
      </div>
    </div>
  );
}

const styles = {
  container: { backgroundColor: '#090d16', color: '#f3f4f6', minHeight: '100vh', fontFamily: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif', position: 'relative', overflow: 'hidden' },
  bgGlowContainer: { position: 'absolute', width: '100%', height: '100%', overflow: 'hidden', zIndex: 0 },
  bgGlow: { position: 'absolute', width: '600px', height: '600px', borderRadius: '50%' },
  wrapper: { maxWidth: '850px', margin: '0 auto', padding: '2rem 1.5rem', position: 'relative', zIndex: 1 },
  nav: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '4rem' },
  logo: { fontSize: '1.25rem', fontWeight: '700', letterSpacing: '-0.02em', background: 'linear-gradient(90deg, #6366f1, #a855f7)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' },
  linkedinBadge: { color: '#9ca3af', textDecoration: 'none', fontSize: '0.875rem', border: '1px solid #1f2937', padding: '0.5rem 1rem', borderRadius: '9999px', backgroundColor: 'rgba(17, 24, 39, 0.6)' },
  hero: { marginBottom: '4rem' },
  badge: { display: 'inline-block', fontSize: '0.75rem', fontWeight: '600', color: '#10b981', backgroundColor: 'rgba(16, 185, 129, 0.1)', border: '1px solid rgba(16, 185, 129, 0.2)', padding: '0.25rem 0.75rem', borderRadius: '9999px', marginBottom: '1rem' },
  heroTitle: { fontSize: '3.25rem', fontWeight: '800', letterSpacing: '-0.03em', margin: '0 0 0.5rem 0', lineHeight: '1.1' },
  heroSubtitle: { fontSize: '1.5rem', color: '#a855f7', margin: '0 0 1.5rem 0', fontWeight: '500' },
  heroBio: { fontSize: '1.125rem', color: '#9ca3af', lineHeight: '1.7', maxWidth: '650px' },
  section: { marginBottom: '4rem' },
  sectionTitle: { fontSize: '1.5rem', fontWeight: '700', marginBottom: '1.5rem', letterSpacing: '-0.02em', borderBottom: '1px solid #1f2937', paddingBottom: '0.75rem' },
  skillsGrid: { display: 'flex', flexWrap: 'wrap', gap: '0.75rem' },
  skillCard: { backgroundColor: 'rgba(31, 41, 55, 0.5)', border: '1px solid #374151', padding: '0.5rem 1rem', borderRadius: '8px', fontSize: '0.875rem', color: '#e5e7eb' },
  timeline: { display: 'flex', flexDirection: 'column', gap: '1.5rem' },
  timelineCard: { backgroundColor: 'rgba(17, 24, 39, 0.5)', border: '1px solid #1f2937', padding: '1.5rem', borderRadius: '12px' },
  timelineHeader: { display: 'flex', justifyContent: 'space-between', alignItems: 'baseline' },
  roleTitle: { margin: 0, fontSize: '1.125rem', color: '#f3f4f6' },
  period: { fontSize: '0.85rem', color: '#6b7280' },
  companyName: { color: '#6366f1', margin: '0.25rem 0 0.75rem 0', fontWeight: '500' },
  timelineDesc: { color: '#9ca3af', fontSize: '0.95rem', margin: 0, lineHeight: '1.5' },
  projectsGrid: { display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '1.5rem' },
  projectCard: { backgroundColor: 'rgba(17, 24, 39, 0.5)', border: '1px solid #1f2937', padding: '1.5rem', borderRadius: '12px', display: 'flex', flexDirection: 'column', justifyContent: 'space-between' },
  projectTitle: { fontSize: '1.2rem', margin: '0 0 0.5rem 0', color: '#f3f4f6' },
  projectDesc: { color: '#9ca3af', fontSize: '0.9rem', lineHeight: '1.6', marginBottom: '1rem' },
  projectTags: { display: 'flex', gap: '0.5rem', flexWrap: 'wrap' },
  tag: { fontSize: '0.75rem', color: '#a855f7', backgroundColor: 'rgba(168, 85, 247, 0.1)', padding: '0.2rem 0.5rem', borderRadius: '4px' },
  footer: { textAlign: 'center', paddingTop: '2rem', borderTop: '1px solid #1f2937', color: '#6b7280', fontSize: '0.875rem' },
};
