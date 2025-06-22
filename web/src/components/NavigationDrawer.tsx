import { Link } from "@tanstack/react-router";
import {
  Avatar,
  Box,
  Drawer,
  List,
  ListItem,
  ListItemButton,
  ListItemText,
  Typography,
} from "@mui/material";
import {
  DashboardOutlined,
  SettingsOutlined,
  SchoolOutlined,
  PersonOutlined,
  BuildOutlined,
  LocalPostOfficeOutlined,
  InfoOutline,
  ListAltOutlined,
  GradeOutlined,
  GroupsOutlined,
} from "@mui/icons-material";

const loggedInUser = {
    username: "151385@uexample.edu",
    displayName: "John User"
}
const initials = loggedInUser.displayName.split(" ")[0][0] + loggedInUser.displayName.split(" ")[1][0]

const drawerWidth = 240;
const navEntries = [
  {
    icon: <SchoolOutlined />,
    name: "Attend",
    link: "/attend",
  },
  {
    icon: <DashboardOutlined />,
    name: "Dashboard",
    link: "/",
  },
  {
    icon: <PersonOutlined />,
    name: "People",
    link: "/people",
  },
  {
    icon: <GroupsOutlined />,
    name: "Groups",
    link: "/groups",
  },
  {
    icon: <ListAltOutlined />,
    name: "Courses",
    link: "/courses",
  },
  {
    icon: <InfoOutline />,
    name: "Reports",
    link: "/reports",
  },
  {
    icon: <BuildOutlined />,
    name: "Admin",
    link: "/admin",
  },
  {
    icon: <SettingsOutlined />,
    name: "Settings",
    link: "/settings",
  },
];

export default function NavigationDrawer({ children }: { children: any }) {
  return (
    <Box sx={{ display: "flex" }}>
      <Drawer
        variant="permanent"
        sx={{
          width: drawerWidth,
          flexShrink: 1,
          [`& .MuiDrawer-paper`]: {
            width: drawerWidth,
            boxSizing: "border-box",
          },
        }}
      >
        <Box sx={{ display: "flex", flexDirection: "column", height: "100%" }}>
          <List sx={{ flexGrow: 1 }}>
            {navEntries.map((entry) => {
              return (
                <ListItem disablePadding>
                  <ListItemButton component={Link} to={entry.link}>
                    {entry.icon}
                    <ListItemText
                      primary={entry.name}
                      style={{ marginLeft: "5%" }}
                    />
                  </ListItemButton>
                </ListItem>
              );
            })}
          </List>
          <Box sx={{ p: 2, borderTop: "1px solid #ddd" }}>
            <Box sx={{ display: "flex", alignItems: "center" }}>
              <Avatar sx={{ mr: 1 }}>{initials}</Avatar>
              <Typography variant="body2">{loggedInUser.displayName}</Typography>
            </Box>
          </Box>
        </Box>
      </Drawer>
      <Box
        component="main"
        sx={{ flexGrow: 1, bgcolor: "background.default", p: 3 }}
      >
        {children}
      </Box>
    </Box>
  );
}
