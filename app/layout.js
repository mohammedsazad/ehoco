import "./globals.css";
import Header from "@/components/Header";

export const metadata = {
  title: "HOCO — Smart Accessories",
  description: "HOCO electronics accessories store",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        <div className="topbar">
          FREE SHIPPING ABOVE ₹999 • EASY RETURNS
        </div>

        <Header />

        <main>{children}</main>

        <footer className="footer">
          <div className="shell footerGrid">
            <div>
              <b className="footerLogo">HOCO</b>
              <p>
                Smart accessories for phones, laptops and everyday tech.
              </p>
            </div>

            <div>
              <b>Shop</b>
              <a href="/?category=Mobile">Mobile</a>
              <a href="/?category=Laptop">Laptop</a>
              <a href="/?category=Audio">Audio</a>
            </div>

            <div>
              <b>Help</b>
              <a href="/account">My account</a>
              <a href="/orders">Orders</a>
              <a href="/">Support</a>
            </div>
          </div>

          <div className="shell copyright">
            © 2026 HOCO
          </div>
        </footer>
      </body>
    </html>
  );
}
