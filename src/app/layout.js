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
