import { Card, CardContent, Typography } from "@mui/material";

export default function DashboardCard({ children }: { children: any }) {
  return (
    <Card>
      <CardContent style={{ textAlign: "center" }}>
        <Typography>Example Card</Typography>
        {children}
      </CardContent>
    </Card>
  );
}
